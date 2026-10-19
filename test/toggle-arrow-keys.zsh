#!/usr/bin/env zsh
# Tests for bin/toggle-arrow-keys. Each case runs a copy of the script in a
# sandbox repo with a fake launchctl, so the real config and Karabiner are untouched.
# Run: test/toggle-arrow-keys.zsh

DOTFILES_DIR="${0:A:h:h}"
failures=0

# Fresh sandbox: script, lib.sh, the real config, and a fake launchctl that
# logs its calls and exits with $FAKE_LAUNCHCTL_EXIT.
setup() {
  sandbox=$(mktemp -d)
  mkdir -p "$sandbox/bin" "$sandbox/config/karabiner" "$sandbox/fakebin"
  /bin/cp "$DOTFILES_DIR/bin/toggle-arrow-keys" "$DOTFILES_DIR/bin/lib.sh" "$sandbox/bin/"
  /bin/cp "$DOTFILES_DIR/config/karabiner/karabiner.json" "$sandbox/config/karabiner/"
  config="$sandbox/config/karabiner/karabiner.json"
  /bin/cp "$config" "$sandbox/original.json"
  cat > "$sandbox/fakebin/launchctl" <<'EOF'
#!/bin/sh
echo "$@" >> "$(dirname "$0")/calls"
exit "${FAKE_LAUNCHCTL_EXIT:-0}"
EOF
  chmod +x "$sandbox/fakebin/launchctl"
}

run() {
  PATH="$sandbox/fakebin:$PATH" NO_COLOR=1 FAKE_LAUNCHCTL_EXIT=${FAKE_LAUNCHCTL_EXIT:-0} "$sandbox/bin/toggle-arrow-keys" > "$sandbox/out" 2>&1
  code=$?
}

check() {  # check <description> <condition...>
  local desc=$1; shift
  if "$@"; then
    print "ok    $desc"
  else
    print "FAIL  $desc"
    sed 's/^/      | /' "$sandbox/out"
    (( failures++ ))
  fi
}

unchanged()  { cmp -s "$config" "$sandbox/original.json"; }
output_has() { grep -qF -- "$1" "$sandbox/out"; }
valid_json() { python3 -m json.tool "$config" > /dev/null 2>&1; }
restarts()   { local calls="$sandbox/fakebin/calls"; [[ $( [[ -f $calls ]] && wc -l < $calls || echo 0) -eq $1 ]]; }

setup
run
check "toggle on: exits 0"                  test $code -eq 0
check "toggle on: says on"                  output_has "Arrow keys: on"
check "toggle on: removes rule"             test -z "$(grep 'Disable bare arrow keys' "$config")"
check "toggle on: still valid JSON"         valid_json
check "toggle on: restarts both services"   restarts 2
run
check "toggle off: says off"                output_has "Arrow keys: off"
check "toggle off: byte-identical original" unchanged

setup
rm "$config"
run
check "missing config: exits 1"             test $code -eq 1
check "missing config: names the file"      output_has "$config"
check "missing config: no restart"          restarts 0

setup
sed -i '' 's/"key_code": "left_arrow" }/"key_code":"left_arrow"}/' "$config"
/bin/cp "$config" "$sandbox/original.json"
run
check "reformatted rule: exits 1"           test $code -eq 1
check "reformatted rule: no duplicate added" unchanged
check "reformatted rule: explains"          output_has "doesn't match"

setup
python3 - "$config" <<'EOF'
import json, sys
path = sys.argv[1]
data = json.load(open(path))
rules = data["profiles"][0]["complex_modifications"]["rules"]
rules.insert(1, rules[1])
json.dump(data, open(path, "w"), indent=4)
EOF
/bin/cp "$config" "$sandbox/original.json"
run
check "duplicate rule: exits 1"             test $code -eq 1
check "duplicate rule: unchanged"           unchanged
check "duplicate rule: explains"            output_has "Found 2"

setup
sed -i '' '/Disable bare arrow keys/d; /Ctrl+h\/j\/k\/l/d' "$config"
/bin/cp "$config" "$sandbox/original.json"
run
check "no anchor: exits 1"                  test $code -eq 1
check "no anchor: unchanged"                unchanged

setup
chmod a-w "$config"
run
check "read-only config: exits 1"           test $code -eq 1
check "read-only config: unchanged"         unchanged
check "read-only config: names the file"    output_has "$config"
check "read-only config: no restart"        restarts 0

setup
FAKE_LAUNCHCTL_EXIT=113 run
check "restart fails: exits 1"              test $code -eq 1
check "restart fails: says config changed"  output_has "arrow keys on in"
check "restart fails: says to restart"      output_has "restart Karabiner"

(( failures == 0 )) && print "\nAll passed" || { print "\n$failures failed"; exit 1; }
