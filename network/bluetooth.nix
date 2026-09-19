# Bluetooth support.
# KDE Plasma ships Bluedevil, so no extra tray applet is needed.
# Audio devices are handled by PipeWire/WirePlumber, enabled in configuration.nix.

{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    # Power the adapter on at boot, so devices can reconnect without a manual toggle
    powerOnBoot = true;
    settings = {
      General = {
        # Expose the battery level of the connected devices
        Experimental = true;
        # Advertise every supported profile (A2DP, HFP, HID, ...)
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    bluetui # Terminal UI to pair and manage devices
  ];
}
