{pkgs, ...}: {
  "search.exclude" = {
    ".*" = true;
  };
  "files.autoSave" = "afterDelay";
  "window.titleBarStyle" = "custom"; # Necessary or VSCode crashes

  "workbench.colorTheme" = "Default High Contrast";
  "workbench.startupEditor" = "none";
  "workbench.sideBar.location" = "right";

  "editor.inlineSuggest.enabled" = true;
  "github.copilot.enable" = {
    "*" = true;
    plaintext = false;
    markdown = false;
    scminput = false;
    typst = false;
    latex = true;
  };
  "editor.rulers" = [
    {
      color = "#b3bbc254";
      column = "95";
    }
  ];
  "git.autofetch" = true;
  "black-formatter.args" = [
    "--version 3.11"
    "--indent-size 2"
  ];
  "redhat.telemetry.enabled" = false;
  "editor.accessibilitySupport" = "off";
  "cSpell.enabled" = true;
  "cSpell.enableFiletypes" = ["typst"];
  "typescript.updateImportsOnFileMove.enabled" = "always";
  "javascript.updateImportsOnFileMove.enabled" = "always";
  "editor.lineNumbers" = "relative";
  "errorLens.exclude" = [
    "spell"
    "unknown word"
    "replace"
    "quote"
    "remove"
    "delete"
    "trailing"
    "insert"
    "scope"
    "missin"
  ];
  "rust-analyzer.server.path" = "rust-analyzer";

  "[nginx]" = {
    "editor.defaultFormatter" = "raynigon.nginx-formatter";
  };
  "[dockercompose]" = {
    "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
  };
  "[python]" = {
    "editor.formatOnType" = true;
    "editor.defaultFormatter" = "mikoz.black-py";
  };
  "[json]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[typescriptreact]" = {
    "editor.defaultFormatter" = "vscode.typescript-language-features";
  };
  "[javascript]" = {
    "editor.defaultFormatter" = "vscode.typescript-language-features";
  };
  "[typescript]" = {
    "editor.defaultFormatter" = "vscode.typescript-language-features";
  };
  "[svg]" = {
    "editor.defaultFormatter" = "jock.svg";
  };
  "[html]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[jsonc]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[css]" = {
    "ditor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[javascriptreact]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[typst]" = {
    "editor.defaultFormatter" = "myriad-dreamin.tinymist";
  };

  "svg.preview.mode" = "svg";

  "latex-workshop.view.outline.sections" = [
    "chapter"
    "section"
    "subsection"
    "subsubsection"
  ];

  "prettier.printWidth" = "98";
  "prettier.tabWidth" = "4";

  "tinymist.formatterMode" = "typstyle";
  "git.enableSmartCommit" = true;

  "typst-lsp.experimentalFormatterMode" = "on";
  "typst-lsp.serverPath" = "typst-lsp";

  "vim.enableNeovim" = true;
  "vim.neovimPath" = "${pkgs.neovim}/bin/nvim";
  "vim.useSystemClipboard" = false;
  "vim.leader" = "<space>";
  "vim.highlightedyank.enable" = true;
  "vim.hlsearch" = true;
  "vim.showMarksInGutter" = true;
  "vim.smartRelativeLine" = true;
  "vim.normalModeKeyBindings" = [
    {
      before = ["<C-u>"];
      after = ["<C-u>" "z" "z"];
    }
    {
      before = ["<C-d>"];
      after = ["<C-d>" "z" "z"];
    }
    {
      before = ["g" "n" "r"];
      commands = ["editor.action.rename"];
    }
    # Open the command palette
    {
      before = ["<leader>" "f" "p"];
      commands = ["workbench.action.showCommands"];
    }
    # Do a search across all files
    {
      before = ["<leader>" "f" "g"];
      commands = ["workbench.action.findInFiles"];
    }
    # Open the file finding search
    {
      before = ["<leader>" "f" "f"];
      commands = ["workbench.action.quickOpen"];
    }
    # Code actions
    {
      before = ["g" "r" "a"];
      commands = ["editor.action.quickFix"];
    }
    # Go to definition
    {
      before = ["g" "d"];
      commands = ["editor.action.goToDeclaration"];
    }

    #See more
    {
      before = ["K"];
      commands = ["editor.action.showDefinitionPreviewHover"];
    }

    # Regular Navigation
    {
      before = ["o"];
      after = ["A" "Enter"];
    }
    {
      before = ["O"];
      after = ["I" "Enter" "Up"];
    }
    {
      before = ["<leader>" "p" "p"];
      commands = ["editor.action.formatDocument"];
    }

    # Diagnostic Navigation
    {
      before = ["[" "d"];
      commands = ["editor.action.marker.prev"];
    }
    {
      before = ["]" "d"];
      commands = ["editor.action.marker.next"];
    }

    # Git commands
    {
      before = ["<leader>" "f" "h" "h"];
      commands = ["gitlens.quickOpenFileHistory"];
    }
  ];
}
