#!/bin/sh

# Reads all source files and tags as a warning or error any text like
# "TODO:" or "ERROR:"
#
# Based on:
# https://krakendev.io/blog/generating-warnings-in-xcode

# Exit on (-e) error, (-u) undefined variables,
# and (-o pipefail) command pipe failure
set -eu -o pipefail

WARN_TAGS="TODO|FIXME|WARN|WARNING"
ERROR_TAGS="ERROR"

{ \
  # All source folders
  find -f \
    "${SRCROOT}/Sources" \
    "${SRCROOT}/Tests" \
    "${SRCROOT}/Playgrounds.playground" \
  -type f \
  \( -name "*.h" -or -name "*.m" -or -name "*.swift" \) \
  -print0 \
&& \
  # Source files in the root folder
  find "${SRCROOT}" \
  -maxdepth 1 \
  -type f \
  \( -name "*.h" -or -name "*.m" -or -name "*.swift" \) \
  -print0 ;\
} \
| xargs -0 egrep --with-filename --line-number --only-matching \
  "($WARN_TAGS):.*\$|($ERROR_TAGS):.*\$" \
| perl -p -e "s/($WARN_TAGS):/ warning: \$1:/" \
| perl -p -e "s/($ERROR_TAGS):/ error: \$1:/"

