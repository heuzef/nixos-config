# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{

  # Enable experimental-features
  nix.settings.experimental-features = "nix-command flakes";
  # Increasing the 'download-buffer-size' setting
  nix.settings.download-buffer-size = 524288000;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable ZRAM Swap
  zramSwap.enable = true;

  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  services.desktopManager.plasma6.enable = true;

  # Enable automatic login for the user.
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "heuzef";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "oss";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # KWallet
  # security.pam.services.login.kwallet.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable somes programs
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # Define default user shell
  users.defaultUserShell=pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.heuzef = {
    isNormalUser = true;
    description = "heuzef";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirtd" "docker"];
  };

  # List packages installed in system profile.
  # To search, run: nix search wget
  environment.systemPackages = with pkgs; [
    age
    git
    gparted
    ntfs3g
    sops
    ssh-to-age
    sshfs
    usbutils
    v4l-utils
    vim
    zsh
    zsh-autoenv
    zsh-syntax-highlighting
    oh-my-zsh
  ];

  # List of default packages to exclude from the configuration
  environment.plasma6.excludePackages = with pkgs; [
     kdePackages.elisa
  ];

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 7311 ]; # Telmi-Sync
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data,
  # like file locations and database versions on your system were taken.
  # It‘s perfectly fine and recommended to leave this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
