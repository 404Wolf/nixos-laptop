[
  {
    key = "alt+c";
    command = "workbench.action.closeActiveEditor";
  }
  {
    key = "shift+alt+,";
    command = "workbench.action.moveEditorLeftInGroup";
    when = "editorTextFocus";
  }
  {
    key = "shift+alt+.";
    command = "workbench.action.moveEditorRightInGroup";
    when = "editorTextFocus";
  }
  {
    key = "alt+,";
    command = "workbench.action.previousEditor";
    when = "editorTextFocus";
  }
  {
    key = "alt+.";
    command = "workbench.action.nextEditor";
    when = "editorTextFocus";
  }
]
++ [
  {
    key = "ctrl+n";
    command = "workbench.action.toggleSidebarVisibility";
  }
  {
    key = "ctrl+shift+i";
    command = "inlineChat.start";
    when = "editorFocus && inlineChatHasProvider && !editorReadonly";
  }
  {
    key = "j";
    command = "workbench.action.interactivePlayground.arrowDown";
    when = "interactivePlaygroundFocus && !editorTextFocus";
  }
  {
    key = "down";
    command = "-workbench.action.interactivePlayground.arrowDown";
    when = "interactivePlaygroundFocus && !editorTextFocus";
  }
  {
    key = "k";
    command = "workbench.action.interactivePlayground.arrowUp";
    when = "interactivePlaygroundFocus && !editorTextFocus";
  }
  {
    key = "up";
    command = "-workbench.action.interactivePlayground.arrowUp";
    when = "interactivePlaygroundFocus && !editorTextFocus";
  }
]
++ [
  {
    key = "ctrl+l";
    command = "workbench.action.focusRightGroup";
    when = "editorTextFocus";
  }
  {
    key = "ctrl+h";
    command = "workbench.action.focusLeftGroup";
    when = "editorTextFocus";
  }
  {
    key = "ctrl+j";
    command = "workbench.action.focusBelowGroup";
    when = "editorTextFocus";
  }
  {
    key = "ctrl+k";
    command = "workbench.action.focusAboveGroup";
    when = "editorTextFocus";
  }
]
++ [
  {
    key = "ctrl+h";
    command = "-editor.action.startFindReplaceAction";
    when = "editorFocus || editorIsOpen";
  }
  {
    key = "ctrl+h";
    command = "-extension.vim_ctrl+h";
    when = "editorTextFocus && vim.active && vim.use<C-h> && !inDebugRepl";
  }
]
