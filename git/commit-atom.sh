#!/bin/bash

# Get the location of the file to edit from Git.
FILE_TO_EDIT="$1"

# If the file we're editing is a commit message, we can assume Atom is set up
# to insert the magic token when the editor closes. Otherwise, we need to let
# Atom tell Git when it is done.
#
if [[ $(basename "$FILE_TO_EDIT") == "COMMIT_EDITMSG" ]]
then
  # Tell Atom to open the file in an existing window.
  atom "$FILE_TO_EDIT"

  # Wait for Atom to write the magic marker - ##ATOM EDIT COMPLETE## - to signal
  # that the editor has been closed.
  #
  tail -f "$FILE_TO_EDIT" | while read LOGLINE
  do
    [[ "$LOGLINE" == "##ATOM EDIT COMPLETE##" ]] && pkill -P $$ tail
  done

else
  # Tell Atom to open the file in a new window and report when it is finished.
  atom --wait "$FILE_TO_EDIT"
fi
