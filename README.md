# gitmas

A specialized git utility.

## Overview

gitmas will present a list of your changed lines with a count. For example, if `Enabled = "True"` shows up five times across three files, gitmas will show that as one line item with a count of 5. You can then stage or revert all of those occurrences, or use the diffs to stage or revert some or all through contextual menu items.

gitmas is not a complete git client, but rather meant to be used in conjunction with other tools. As such, there is no option to commit or view staged changes.

## Requirements

A recent `git` command line utility must be installed and discoverable though your shell path. To verify this, open a terminal or shell and type `git --version`.

## Who Did This?

This was created by Kem Tekinay of MacTechnologies Consulting.
ktekinay at mactechnologies dot com

See the included LICENSE file for the legal stuff.

With special thanks for testing and suggestions to:

* Jeremy Cowgar
* Justin Elliott

## Release Notes

**1.0** (Aug. 15, 2020)

* Initial release