{ config, lib, pkgs, ... }:

{
  # Shared MCP connectors
  # https://home-manager-options.extranix.com/?query=programs.mcp
  #
  # Secrets never reach the store: only the path of the SOPS-decrypted file does. 
  # Home Manager generates a wrapper script that reads that file when the server starts, 
  # so this does not depend on shell exports (the MCP server is spawned by Claude Code, not by zsh).
  programs.mcp = {
    enable = true;
    servers = {
      # Declarative equivalent of: 
      # claude mcp add mindwtr -s user --env MINDWTR_MCP_CLOUD_URL=... --env MINDWTR_MCP_CLOUD_TOKEN=... -- npx -y mindwtr-mcp --write
      mindwtr = {
        command = "${pkgs.nodejs_22}/bin/npx";
        args = [ "-y" "mindwtr-mcp" "--write" ];
        env = {
          MINDWTR_MCP_CLOUD_URL.file = config.sops.secrets.MINDWTR_MCP_CLOUD_URL.path;
          MINDWTR_MCP_CLOUD_TOKEN.file = config.sops.secrets.MINDWTR_MCP_CLOUD_TOKEN.path;
        };
      };
    };
  };

  # Claude Code: Anthropic's official CLI
  # https://home-manager-options.extranix.com/?query=programs.claude-code
  #
  # This module manages:
  #   ~/.claude/settings.json
  #   ~/.claude/skills/claude-code-home-manager/.mcp.json  (MCP connectors)
  #
  # NOTE: those files become read-only symlinks into the store. 
  # They can no longer be edited through /config or `claude mcp add`, everything goes through this file from now on.
  programs.claude-code = {
    enable = true;
    package = pkgs.claude-code;

    # Pull in the servers declared in programs.mcp above.
    enableMcpIntegration = true;

    # ~/.claude/settings.json
    settings = {
      model = "opus";
      effortLevel = "high";
      theme = "auto";
      agentPushNotifEnabled = true;
      skipDangerousModePermissionPrompt = true;
      includeCoAuthoredBy = false;
    };
  };
}
