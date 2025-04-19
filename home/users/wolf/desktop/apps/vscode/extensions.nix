{pkgs, ...}: let
  from-marketplace = pkgs.vscode-utils.extensionsFromVscodeMarketplace;
  extensions = pkgs.vscode-extensions;
in
  (with extensions; [
    james-yu.latex-workshop
    vscjava.vscode-maven
    firsttris.vscode-jest-runner
    ms-python.isort
    samuelcolvin.jinjahtml
    github.copilot
    myriad-dreamin.tinymist
    vscjava.vscode-java-pack
    dbaeumer.vscode-eslint
    usernamehw.errorlens
    batisteo.vscode-django
    aaron-bond.better-comments
    redhat.vscode-xml
    streetsidesoftware.code-spell-checker
    jock.svg
    prisma.prisma
    shd101wyy.markdown-preview-enhanced
    tomoki1207.pdf
    jnoortheen.nix-ide
    mkhl.direnv
    golang.go
    github.github-vscode-theme
    vscodevim.vim
    rust-lang.rust-analyzer
    eamodio.gitlens
    serayuzgur.crates
    njpwerner.autodocstring
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode.cpptools
    ms-toolsai.jupyter-keymap
    ms-python.debugpy
    ms-vsliveshare.vsliveshare
    golang.go
    denoland.vscode-deno
    (
      ms-toolsai.jupyter.overrideAttrs (final: prev: (prev
        // {
          buildPhase =
            prev.buildPhase
            + ''
              pkg=package.json
              cat $pkg | ${pkgs.jq}/bin/jq ".engines.vscode=\"^1.92.0\"" > $pkg.new
              rm $pkg
              mv $pkg.new $pkg
            '';
        }))
    )
  ])
  ++ from-marketplace [
    {
      name = "python";
      publisher = "ms-python";
      version = "2024.10.0";
      sha256 = "sha256-C7YaluW+FMnAUg2yrqLVqsH6m4qU1riyXz7E3xukPeI=";
    }
    {
      name = "simple-react-snippets";
      publisher = "burkeholland";
      version = "1.2.8";
      sha256 = "sha256-zrRxJZHRqBMGVkd56Q+wDbCSFfl4X3Kta4sX8ecZmu8=";
    }
    {
      name = "vscode-print";
      publisher = "pdconsec";
      version = "0.12.13";
      sha256 = "sha256-ABy9AOQR0FOE1cO1qZiJ72V8Wq+bwavLck3fwNtwF5I=";
    }
    {
      name = "md-paste-enhanced";
      publisher = "dzylikecode";
      version = "2.11.2";
      sha256 = "sha256-n7LYgKcpZ5gHhCrC9sdUYd/lpsHpJ21d31s8JZyyW5c=";
    }
    {
      name = "nginx-formatter";
      publisher = "raynigon";
      version = "0.0.13";
      sha256 = "sha256-pehpoX3reGE7Y4jXLTuyRSIKZRYuragI0GUIwJf7o0I=";
    }
    {
      name = "syntax-mcfunction";
      publisher = "minecraftcommands";
      version = "1.0.0";
      sha256 = "sha256-H92tLZcwrsmAep7z6Z0TxMtYFRa0OAoVIYoXp+vrhzM=";
    }
    {
      name = "sublime-text-4-theme";
      publisher = "emilijanmb";
      version = "1.1.2";
      sha256 = "sha256-I1UO8IEq7HKxgH0gVyUN4cdBOouTvsyMgBjPIYQ6E5U=";
    }
    {
      name = "valtown";
      publisher = "pomdtr";
      version = "0.8.11";
      sha256 = "sha256-NoSCJcu+I64q8aLOi3XzW24kGwQ+y7vlmIIermmL3/g=";
    }
    {
      name = "markdown-mermaid";
      publisher = "bierner";
      version = "1.25.0";
      sha256 = "sha256-UNMpauEPr/K8vLy/lS1Oni4EfBceM9TI6/6713tKS5Y=";
    }
  ]
