#!/usr/bin/env -S bash -l
set -e
backup_dir=

# get backup dir
while getopts 'd:p:' OPTION; do
  case "$OPTION" in
    d)
      backup_dir=$(realpath $OPTARG)
      echo "Backup dir: $backup_dir"
      ;;
    p)
      proxy=$OPTARG
      echo "Use proxy: $proxy"
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

if [ ${proxy:-} == "" ]; then
  proxy_opt=""
else
  proxy_opt="--proxy $proxy"
fi

# loop process each chat id
while [ -n "$1" ]; do
  # if directory not exist, create it
  [ -d "$backup_dir/$1" ] || mkdir -p "$backup_dir/$1"
  chat_dir="$backup_dir/$1" # chat backup dir
  chat_export="$backup_dir/$1/export.json" # chat export.json file

  if [ -f $chat_export ]; then
    max_id=$(cat $chat_export | jq '.messages[].id' | sort -nr | head -n 1)
    tmp_json=$(mktemp)
    tmp_result=$(mktemp)

    # new message
    tdl $proxy_opt chat export -c $1 -T id -i $((max_id + 1)) -o "$tmp_json"
    tdl $proxy_opt dl -f $tmp_json -d "$backup_dir/$1"
    jq -s '{id: .[0].id, messages: [.[] | .messages[]]}' $tmp_json $chat_export > "$tmp_result"
    mv "$tmp_result" $chat_export

    # rm tmp
    [ -f $tmp_json ] && rm $tmp_json
    [ -f $tmp_result ] && rm $tmp_result
  else
    tdl $proxy_opt chat export -c $1 -o $chat_export 
    tdl $proxy_opt dl -f $chat_export -d $chat_dir
  fi
  shift
done
