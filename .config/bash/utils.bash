prepand_path() {
  new_path=$1

  case ":${PATH}:" in
    *:"$new_path":*)
      export PATH="$new_path:$(echo $PATH | sed "s|$new_path||g; s|::|:|g")"
      ;;
    *)
      export PATH="$new_path:$PATH"
      ;;
  esac
}

