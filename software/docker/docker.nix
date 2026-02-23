{ config, lib, pkgs, modulesPath, ... }:

{
  virtualisation.docker = {
    enable = false;
    # Allow USB devices
    extraOptions = [
      "--default-ulimit=nofile=1024:524288"
    ];
    # Customize Docker daemon settings using the daemon.settings option
    daemon.settings = {
      experimental = true;
    };
    # Use the rootless mode - run Docker daemon as non-root user
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # udev rule to allow USB devices
  services.udev.packages = with pkgs; [ eudev ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", GROUP="docker", MODE="0666"
  '';

  environment.systemPackages = with pkgs; [
    lazydocker
  ];
}
