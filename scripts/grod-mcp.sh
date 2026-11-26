#!/bin/sh
# Starts the MCP server built into GRØD, then gets out of the way.
#
# This script reads no meetings and sends nothing anywhere. It finds your copy
# of GRØD and replaces itself with it (exec), so Claude talks to GRØD directly
# over standard input and output. GRØD then reads its own meeting store with
# saving turned off, and only if Allow MCP apps is on in GRØD's settings.
#
# Where it looks for GRØD, in order:
#   1. GROD_APP, if set: the path to a GRØD.app, for development builds.
#   2. The copy of GRØD that is running now.
#   3. /Applications/GRØD.app, then ~/Applications/GRØD.app.
#   4. A copy Spotlight knows, by GRØD's bundle identifier.

bundle_id="com.gaspery.grod"

usable() {
  [ -n "$1" ] && [ -x "$1/Contents/MacOS/GRØD" ]
}

app="${GROD_APP:-}"

if ! usable "$app"; then
  app=$(/usr/bin/lsappinfo info -only bundlepath -app "$bundle_id" 2>/dev/null |
    /usr/bin/sed -n 's/^[[:space:]]*bundle path="\([^"]*\)".*$/\1/p' |
    /usr/bin/head -n 1)
fi

if ! usable "$app"; then
  app="/Applications/GRØD.app"
fi

if ! usable "$app"; then
  app="$HOME/Applications/GRØD.app"
fi

if ! usable "$app"; then
  app=$(/usr/bin/mdfind "kMDItemCFBundleIdentifier == '$bundle_id'" 2>/dev/null |
    /usr/bin/head -n 1)
fi

if ! usable "$app"; then
  echo "GRØD isn't installed on this Mac, so Claude can't read its meetings. Install GRØD, open it once, and turn on Allow MCP apps in its settings." >&2
  exit 69
fi

exec "$app/Contents/MacOS/GRØD" --mcp-stdio
