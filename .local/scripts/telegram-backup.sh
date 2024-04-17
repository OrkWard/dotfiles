#!/usr/bin/env bash
set -e
backup_dir=

# get backup dir
while getopts 'd:' OPTION; do
  case "$OPTION" in
    d)
      backup_dir=$(realpath $OPTARG)
      echo "Backup dir: $backup_dir"
      ;;
    ?)
      echo "usage: telegram-backup.sh -d <backup_dir> chat_id..."
      echo "your command: $0 $@"
      exit 1
  esac
done
if [ $backup_dir == "" ]; then
  echo "usage: telegram-backup.sh -d <backup_dir> chat_id..."
  echo "your command: $0 $@"
  exit 1
fi
shift "$(($OPTIND - 1))"

# loop process each chat id
while [ -n "$1" ]; do
  # if directory not exist, create it
  [ -d "$backup_dir/$1" ] || mkdir -p "$backup_dir/$1"
  if [ -f "$backup_dir/$1/export.json" ]; then
    max_id=$(cat "$backup_dir/$1/export.json" | jq '.messages[].id' | sort -nr | head -n 1)
    tmp_json=$(mktemp)
    tdl chat export -c $1 -T id -i $((max_id + 1)) -o "$tmp_json"
    tdl dl -f $tmp_json -d "$backup_dir/$1"
    jq -s '{id: .[0].id, messages: [.[].messages[]]}' $tmp_json "$backup_dir/$1/export.json" > "$backup_dir/$1/export.json"
    [ -f tmp_json ] && rm tmp_json
  else
    tdl chat export -c $1 -o "$backup_dir/$1/export.json"
    tdl dl -f "$backup_dir/$1/export.json" -d "$backup_dir/$1"
  fi
  shift
done
