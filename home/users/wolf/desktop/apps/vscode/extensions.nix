{ pkgs, ... }:
(with pkgs; [
  # nix
  open-vsx.jnoortheen.nix-ide
  open-vsx.mkhl.direnv

  # python
  open-vsx.ms-python.isort
  open-vsx.ms-python.debugpy
  open-vsx.njpwerner.autodocstring
  open-vsx.detachhead.basedpyright

  # rust
  open-vsx.rust-lang.rust-analyzer
  open-vsx.serayuzgur.crates

  # go
  open-vsx.golang.go

  # java
  open-vsx.vscjava.vscode-maven
  open-vsx.vscjava.vscode-java-pack

  # javascript/typescript
  open-vsx.firsttris.vscode-jest-runner
  open-vsx.dbaeumer.vscode-eslint
  open-vsx.denoland.vscode-deno
  open-vsx.astro-build.astro-vscode
  open-vsx.unifiedjs.vscode-mdx

  # c/c++
  vscode-marketplace.ms-vscode.cpptools

  # markup/config languages
  open-vsx.redhat.vscode-yaml
  open-vsx.tamasfe.even-better-toml
  open-vsx.redhat.vscode-xml
  open-vsx.shd101wyy.markdown-preview-enhanced
  open-vsx.quarto.quarto

  # latex
  open-vsx.james-yu.latex-workshop

  # typst
  open-vsx.myriad-dreamin.tinymist

  # ruby
  vscode-marketplace.shopify.ruby-extensions-pack

  # general
  open-vsx.usernamehw.errorlens
  open-vsx.aaron-bond.better-comments
  open-vsx.vscodevim.vim
  open-vsx.eamodio.gitlens
  open-vsx.streetsidesoftware.code-spell-checker
  vscode-extensions.github.copilot
])

# For custom extensions (I got rid of mine)
# extensions = pkgs.vscode-marketplace;
# pkgs.vscode-utils.extensionsFromVscodeMarketplace {
#   name = "sorbet-vscode-extension";
#   publisher = "sorbet";
#   version = "0.3.46";
#   sha256 = "sha256-fKJbaJgsLgypprylbUKUjyeU1B9x0RlaD1dUnFd1w7Y=";
# }
