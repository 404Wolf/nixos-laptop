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

  "editor.experimentalGpuAcceleration" = "on";

  "editor.experimental.preferTreeSitter.ini" = true;
  "editor.experimental.preferTreeSitter.css" = true;
  "editor.experimental.preferTreeSitter.typescript" = true;
  "editor.experimental.preferTreeSitter.regex" = true;
  "editor.experimental.treeSitterTelemetry" = true;

  "editor.inlayHints.enabled" = true;

  "github.copilot.nextEditSuggestions.enabled" = "true";
  "github.copilot.chat.editor.temporalContext.enabled" = true;
  "github.copilot.chat.edits.temporalContext.enabled" = true;
  "github.copilot.chat.edits.suggestRelatedFilesFromGitHistory" = true;

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
      before = [
        "g"
        "i"
      ];
      commands = ["editor.action.goToImplementation"];
    }

    {
      before = [
        "g"
        "t"
      ];
      commands = ["editor.action.goToTypeDefinition"];
    }

    {
      before = [
        "g"
        "r"
      ];
      commands = ["editor.action.referenceSearch.trigger"];
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
