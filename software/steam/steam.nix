{ config, lib, pkgs, modulesPath, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.steam.gamescopeSession.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  environment.systemPackages = with pkgs; [
    steam-tui
    steamcmd
  ];
}
