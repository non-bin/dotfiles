#!/bin/bash

flags=("--allow-read")

# if first arg is -c, run `deno compile "${flags[@]}" main.ts` then pass the rest of the args to the compiled binary
if [ "$1" == "-c" ]; then
  deno compile "${flags[@]}" -o ./main main.ts
  shift
  ./main "$@"
else
  deno run "${flags[@]}" main.ts "$@"
fi
