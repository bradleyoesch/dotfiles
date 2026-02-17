#!/opt/homebrew/bin/zsh

set -e

CONFIG="install.conf.yaml"
DOTBOT_DIR="dotbot"

DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

# Ensure ~/.config/dotfiles directory exists for symlinks
mkdir -p ~/.config/dotfiles

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" \
  -p dotbot-if/if.py \
  -p dotbot-ed/ed.py \
  -c "${CONFIG}" "${@}"
