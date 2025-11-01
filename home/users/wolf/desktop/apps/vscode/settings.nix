{pkgs, ...}: {
  "chat.setupFromDialog" = false;
  "search.exclude" = {
    ".*" = true;
  };
  "window.titleBarStyle" = "custom"; # Necessary or VSCode crashes

  "cSpell.enabled" = true;
  "cSpell.userWords" = [
    "hyperparameters"
  ];

  "workbench.colorTheme" = "Default High Contrast";
  "workbench.startupEditor" = "none";
  "workbench.sideBar.location" = "right";

  "editor.tabSize" = 2;

  "editor.inlineSuggest.enabled" = true;
  "editor.guides.bracketPairs" = true;
  "editor.guides.bracketPairsHorizontal" = true;

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

  "rust-analyzer.server.path" = "rust-analyzer";

  "nix.enableLanguageServer" = true;

  "svg.preview.mode" = "svg";

  "latex-workshop.view.outline.sections" = [
    "chapter"
    "section"
    "subsection"
    "subsubsection"
  ];

  "tinymist.formatterMode" = "typstyle";
  "git.enableSmartCommit" = true;

  "[nginx]" = {
    "editor.defaultFormatter" = "raynigon.nginx-formatter";
  };
  "[markdown]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
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

  "git.autofetch" = true;
  "black-formatter.args" = [
    "--version 3.11"
    "--indent-size 2"
  ];
  "redhat.telemetry.enabled" = false;
  "editor.accessibilitySupport" = "off";
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

  "workbench.activityBar.location" = "hidden";
  "window.menuBarVisibility" = "toggle";
  "window.commandCenter" = false;

  "vim.enableNeovim" = true;
  "vim.neovimPath" = "${pkgs.neovim}/bin/nvim";
  "vim.foldfix" = true;
  "vim.useSystemClipboard" = false;
  "vim.leader" = "<space>";
  "vim.highlightedyank.enable" = true;
  "vim.hlsearch" = true;
  "vim.showMarksInGutter" = true;
  "vim.smartRelativeLine" = true;
  "vim.normalModeKeyBindings" = [
    {
      before = ["<C-u>"];
      after = [
        "<C-u>"
        "z"
        "z"
      ];
    }
    {
      before = ["<C-d>"];
      after = [
        "<C-d>"
        "z"
        "z"
      ];
    }
    {
      before = [
        "c"
        "d"
      ];
      commands = ["editor.action.rename"];
    }

    {
      before = [
        "<leader>"
        "f"
        "p"
      ];
      commands = ["workbench.action.showCommands"];
    }

    {
      before = [
        "<leader>"
        "f"
        "g"
      ];
      commands = ["workbench.action.findInFiles"];
    }

    {
      before = [
        "<leader>"
        "f"
        "f"
      ];
      commands = ["workbench.action.quickOpen"];
    }

    {
      before = [
        "<leader>"
        "t"
        "t"
      ];
      commands = ["workbench.action.showAllSymbols"];
    }

    {
      before = [
        "g"
        "r"
        "a"
      ];
      commands = ["editor.action.quickFix"];
    }

    {
      before = [
        "g"
        "d"
      ];
      commands = ["editor.action.goToDeclaration"];
    }

    {
      before = ["K"];
      commands = ["editor.action.showDefinitionPreviewHover"];
    }

    {
      before = ["o"];
      after = [
        "A"
        "Enter"
      ];
    }
    {
      before = ["O"];
      after = [
        "I"
        "Enter"
        "Up"
      ];
    }
    {
      before = [
        "<leader>"
        "p"
        "p"
      ];
      commands = ["editor.action.formatDocument"];
    }

    {
      before = [
        "["
        "d"
      ];
      commands = ["editor.action.marker.prev"];
    }
    {
      before = [
        "]"
        "d"
      ];
      commands = ["editor.action.marker.next"];
    }

    # Git commands
    {
      before = [
        "<leader>"
        "f"
        "h"
        "h"
      ];
      commands = ["gitlens.quickOpenFileHistory"];
    }
  ];
}
