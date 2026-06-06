#!/usr/bin/env bash
set -eo pipefail

EDIT="false"
COPY="true"
POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -e | --edit)
      EDIT="true"
      shift # past argument
      ;;
    -c | --copy)
      COPY="true"
      shift # past argument
      ;;
    -C | --no-copy)
      COPY="false"
      shift # past argument
      ;;
    -* | --*)
      echo "Unknown option $1"

      echo "Usage: screenshot.sh [options] [filename]"
      echo "Prints the path to the saved file"
      echo
      echo "filename defaults to '\$HOME/Pictures/Screenshots/\$\(date +%Y-%m-%d_%H.%M.%S\).png'"
      echo
      echo "Options:"
      echo "  -e, --edit    Open swappy to edit the screenshot after capture"
      echo "  -c, --copy    Copy the image contents to the clipboard (default)"
      echo "  -C, --no-copy Do not copy the image contents to the clipboard"
      echo
      echo "Options must be specified with separate tacs (these: '-'). For example use '-u -c -P' not '-ucP"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift                   # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

OUTPUT_FILENAME="$1"
[ "$OUTPUT_FILENAME" == "" ] && OUTPUT_FILENAME="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H.%M.%S).png"

if [ $EDIT == "true" ]; then
  INITIAL_FILENAME="/tmp/screenshot.png"
else
  INITIAL_FILENAME="$OUTPUT_FILENAME"
fi

# https://github.com/emersion/slurp/issues/16#issuecomment-3244586972
grim -t png -g "$(
  hyprctl clients -j |
    jq --argjson active "$(
      hyprctl monitors -j |
        jq -c "[.[].activeWorkspace.id]"
    )" '.[] | select((.hidden | not) and (.workspace.id as $id | $active | contains([$id]))) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' -r |
    slurp -d
)" "$INITIAL_FILENAME"

if [ $EDIT == "true" ]; then
  swappy -f "/tmp/screenshot.png" -o "$OUTPUT_FILENAME"
fi

if [ $COPY == "true" ]; then
  wl-copy <"$OUTPUT_FILENAME"
fi

echo "$OUTPUT_FILENAME"
