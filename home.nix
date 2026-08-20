{ config, lib, pkgs, ... }:

{
  # Home Manager
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "heuzef";
  home.homeDirectory = "/home/heuzef";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # SOPS
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets/secrets.enc.yaml;
    secrets = {
      MISTRAL_API_KEY = {};
      id_ed25519 = { path = "${config.home.homeDirectory}/.ssh/id_ed25519"; };
      id_ed25519_pub = { path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub"; };
      data_engineering_machine_pem = {path = "${config.home.homeDirectory}/.ssh/data_engineering_machine.pem";};
      id_rsa = { path = "${config.home.homeDirectory}/.ssh/id_rsa"; };
      id_rsa_pub = { path = "${config.home.homeDirectory}/.ssh/id_rsa.pub"; };
    };
  };

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    apostrophe
    appimage-run
    audacity
    azure-cli
    bat
    btop
    claude-code
    dig
    eza
    ferdium
    ffmpeg
    freecad
    freerdp
    ghostscript
    gimp3
    go
    google-chrome
    hugo
    inkscape
    kdePackages.kcalc
    kdePackages.kdenlive
    kdePackages.kglobalaccel
    lastversion
    libreoffice-fresh
    librewolf
    mpv
    naps2
    prusa-slicer
    qbittorrent
    seafile-client
    signal-desktop
    superfile
    tree
    vim
    vlc
    wget
    yt-dlp
    zoom-us
  ];

  # Git
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings.user.name = "Heuzef";
    settings.user.email = "contact@heuzef.com";
  };

  # SSH
  home.file.".ssh/config".text = lib.concatStringsSep "\n" (
    let
      sshDefaults = {
        user = "root";
        identityFile = "~/.ssh/id_ed25519";
      };

      sshHosts = [
        { name = "pve"; hostName = "192.168.0.100"; }
        { name = "proxy"; hostName = "192.168.0.101"; }
        { name = "backup"; hostName = "192.168.0.102"; }
        { name = "vault"; hostName = "192.168.0.103"; }
        { name = "budget"; hostName = "192.168.0.104"; }
        { name = "notes"; hostName = "192.168.0.105"; }
        { name = "claw"; hostName = "192.168.0.106"; extraConfig = "LocalForward 18789 127.0.0.1:18789"; }
        { name = "files"; hostName = "192.168.0.110"; }
        { name = "www"; hostName = "192.168.0.122"; }
        { name = "media"; hostName = "192.168.0.190"; }

        # Azure DevOps
        {
          name = "ssh.dev.azure.com";
          hostName = "ssh.dev.azure.com";
          user = "git";
          identityFile = "~/.ssh/heuzef_azuredevops_id_rsa";
          extraConfig = ''
            PubkeyAcceptedKeyTypes +ssh-rsa
            HostkeyAlgorithms +ssh-rsa
          '';
        }
      ];

      sshHostToConfig = host: ''
        Host ${host.name}
          HostName ${host.hostName}
          User ${host.user or sshDefaults.user}
          IdentityFile ${host.identityFile or sshDefaults.identityFile}
          IdentitiesOnly yes
          PreferredAuthentications publickey
          ${host.extraConfig or ""}
      '';
    in
      map sshHostToConfig sshHosts
  );

  # Edit .bashrc to use Home Manager
  home.file.".bashrc".text = ''
    if [ -f "/etc/profiles/per-user/heuzef/etc/profile.d/hm-session-vars.sh" ]; then
      source "/etc/profiles/per-user/heuzef/etc/profile.d/hm-session-vars.sh"
    fi
  '';

  # Enable ZSH and OhMyZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    history.ignoreAllDups = true;
    initContent = ''
      export MISTRAL_API_KEY=$(cat ${config.sops.secrets.MISTRAL_API_KEY.path})
    '';

    # Alias
    shellAliases = {
      ls = "eza --icons";
      ll = "eza --icons -laho --total-size --no-permissions --time-style=long-iso";
      tree = "eza --icons -la --no-permissions --no-filesize --no-user --no-time -T -L2";
      cat = "bat";
      spf = "superfile";
      media = "sshfs root@media:/mnt/DATA_MEDIA/ /home/heuzef/DATA_MEDIA/";
    };

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "crcandy";
      plugins = [
        "history"
        "git"
        "sudo"
        "docker"
      ];
    };
  };

  # Environment variables
  home.sessionVariables = {
    SHELL = "/run/current-system/sw/bin/zsh";
    EDITOR = "vim";
  };
}
