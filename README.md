# Heuzef Nixos-Config

## INIT
* Set Hostname : ``sudo nano /etc/nixos/configuration.nix``, set networking.hostName and ``sudo nixos-rebuild boot ; reboot``
* Install AGE private key for SOPS in : ``~/.config/sops/age/keys.txt``
* Clone GIT repo : ``mkdir ~/GIT ; cd ~/GIT ; nix-shell -p git --command "git clone https://github.com/heuzef/nixos-config.git" ; cd nixos-config``
* Process install : ``./install.sh``
* Re-clone GIT repo with SSH key : ``cd ~/GIT/ ; rm -fr nixos-config/ ; git clone git@github.com:heuzef/nixos-config.git``
* Apply manual configuration (check mynixos.com to improve later) :
    * Check Audio
    * Configure Tiles (Meta + T)
    * Keyboard (model and numlock)
    * Disable Lock screen delay
    * Disable power management
    * Config Trashbin
    * Set defaults app
    * Set auto-launch app
* Setup softwares :
    * Firefox
    * Seafile client
    * NAPS2
    * Hayase (Extensions)
* Import configs files :
    * Import keybinds.kksrc
    * Import Ferdium config
    * Import Prusa config
    * Import OBS config
