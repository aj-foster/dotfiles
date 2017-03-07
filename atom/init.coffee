# This writes the magic token to the end of a commit message. We expect this to
# be run when the commit message editor has been closed.
#
commit_msg_notifier = (path) ->
  process = require("child_process")
  process.exec("echo \"##ATOM EDIT COMPLETE##\" >> " + path.replace /(\s)/g, '\\$1')
  # console.log(path.replace /(\s)/g, '\\$1')

# The following looks at all new editors. If the editor is for a COMMIT_EDITMSG
# file, it sets up a callback for the magic token to be written when the editor
# is closed.
#
setup_commit_msg_notifier = (editor) ->
  if editor.buffer?.file?.getBaseName() == "COMMIT_EDITMSG"
    path = editor.buffer.file.getPath()
    editor.onDidDestroy ->
      commit_msg_notifier(path)

  # Return this, else weird things may happen. Anyone understand why?
  true

# Set up for all editors to be screened for commit messages.
atom.workspace.observeTextEditors(setup_commit_msg_notifier)


# Remove annoying HTML / ERB grammar.
atom.grammars.removeGrammarForScopeName("text.html.erb")