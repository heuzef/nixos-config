# Heuzef Nixos-Config

## INIT
* Change configuration : ``sudo nano /etc/nixos/configuration.nix`` :
   * set networking.hostName
   * set necessary packages : ``git, age, sops``
   * Install AGE private key for SOPS in : ``~/.config/sops/age/keys.txt``
   * rebuild and reboot : ``sudo nixos-rebuild boot ; reboot``
* Clone GIT repo : ``mkdir ~/GIT ; cd ~/GIT ; git clone https://github.com/heuzef/nixos-config.git ; cd nixos-config``
* Process install and reboot : ``sh ~/GIT/nixos-config/rebuild.sh``
* Re-clone GIT repo with SSH key : ``cd ~/GIT/ ; rm -fr nixos-config/ ; git clone git@github.com:heuzef/nixos-config.git``
* Deploy AppImages : ``sh ~/GIT/nixos-config/appimages_deploy.sh``
* Sync fonts : ``mkdir -p ~/.local/share/fonts/ ; ln -s ~/GIT/nixos-config/fonts/* ~/.local/share/fonts/``
* Apply manual configuration (check mynixos.com to improve later) :
    * Check Audio
    * Configure Tiles (Meta + T)
    * Keyboard (model, numlock, Layout)
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
