{ config, lib, pkgs, modulesPath, ... }:

{
  # https://search.nixos.org/packages?channel=25.05&from=0&size=999&sort=relevance&type=packages&query=vscode-extensions
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      catppuccin.catppuccin-vsc
      # google.geminicodeassist
      # kermanx.p2p-live-share
      ms-python.python
      ms-toolsai.jupyter
      ms-toolsai.vscode-jupyter-slideshow
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.jupyter-renderers
      ms-toolsai.jupyter-keymap
      pkief.material-icon-theme
    ];
  };
}
