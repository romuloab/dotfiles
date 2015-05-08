#!/bin/sh

# This script is intended to be used inside vim, so when
# we pipe the buffer to this, the original text don't vanish

# Copy stdin to a temp file, pipe it to host's pbcopy
tee /tmp/_pbcopy | ssh 10.0.2.2 pbcopy
# Outputs the stdin, and remove the temp file
cat /tmp/_pbcopy && rm -f /tmp/_pbcopy
