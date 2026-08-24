#!/bin/bash
# Shared helpers for init.sh and bin/ scripts. Source this, don't execute it.
# printf renders the color escapes in both zsh and bash.

# Emit color only to a real terminal; honor the NO_COLOR convention.
if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  GREEN=$'\033[1;32m'; RED=$'\033[1;31m'; CYAN=$'\033[0;36m'; RESET=$'\033[0m'
else
  GREEN=''; RED=''; CYAN=''; RESET=''
fi

info()    { printf "${CYAN}>>>>> %s <<<<<${RESET}\n" "$1"; }        # step starting
success() { printf "${GREEN}>>>>> %s <<<<<${RESET}\n" "$1"; }       # step done
error()   { printf "${RED}>>>>> %s <<<<<${RESET}\n" "$1" >&2; }      # error, to stderr
