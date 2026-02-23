{ config, lib, pkgs, modulesPath, ... }:

{
  programs.opencode.enable = true;
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "dockerfile"
      "git-firefly"
      "github-actions"
      "html"
      "mistral-vibe"
      "nix"
      "opencode"
      "sql"
    ];
    extraPackages = with pkgs; [
      nixd
      nixfmt
      opencode
    ];
    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      auto_update = false;
      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };
    };
  };
}