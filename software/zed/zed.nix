{ pkgs, ... }:

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
      "latex"
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
    # https://zed.dev/docs/reference/all-settings
    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      format_on_save = "off";
      auto_update = false;
      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
      };
      minimap = {
        show = "always";
        thumb = "always";
      };
    };
  };
}
