#! /usr/bin/env bash
# This assumes you have trang installed via package manager
# which installs a script to provide a "trang" command.
# Make sure you run this, from the root repo directory, before
# commiting any changes to the rnc files (though the pre-commit
# hook will do this for you).

trang csl-next.rnc csl.rng
trang csl.rng csl-next.rnc
rm -f csl.rng
