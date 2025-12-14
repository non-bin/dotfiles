#!/usr/bin/env bash

CONFIG_FILE=$(~/dotfiles/scripts/searchUpFor.sh ".*\/(\.prettierrc(\.(json5?|(ya?|to)ml|[mc]?[jt]s))?|(prettier\.config\.[mc]?[jt]s))$")
NUM_RESULTS=$(echo "$CONFIG_FILE" | wc -l)
if [ $NUM_RESULTS -gt 1 ]; then
  echo "Found $NUM_RESULTS config files! I don't know which to use!"
  # echo $CONFIG_FILE
  exit 1
fi

prettier --config $CONFIG_FILE $@

## Matches
# touch .prettierrc
# touch .prettierrc.json
# touch .prettierrc.json5
# touch .prettierrc.yml
# touch .prettierrc.yaml
# touch .prettierrc.toml
# touch .prettierrc.js
# touch .prettierrc.ts
# touch .prettierrc.mjs
# touch .prettierrc.mts
# touch .prettierrc.cjs
# touch .prettierrc.cts
# touch prettier.config.js
# touch prettier.config.ts
# touch prettier.config.mjs
# touch prettier.config.mts
# touch prettier.config.cjs
# touch prettier.config.cts

## Doesn't match
# touch prettierrc
# touch .prettierrc.ts.bak
# touch .prettierrc.mjs5
# touch .prettierrc.config.mts
# touch prettierrc.cjs
# touch .prettierrc.nop
# touch prettier.config.not
# touch prettier.asd.ts
# touch prettier.configmjs
# touch prettierconfig.mts
# touch .prettier.config.cjs
# touch prettierrc.config.cjs
# touch prettier.config
