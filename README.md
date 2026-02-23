# Heuzef Nixos-Config

## INIT
* Set Hostname : ``sudo nano /etc/nixos/configuration.nix``, set networking.hostName and ``sudo nixos-rebuild boot ; reboot``
* Install AGE private key for SOPS in : ``~/.config/sops/age/keys.txt``
* Clone GIT repo : ``mkdir GIT ; cd GIT ; nix-shell -p git --command "git clone git@github.com:heuzef/nixos-config.git"``
* Process install : ``./install.sh``
* Apply manual configuration (check mynixos.com to improve later) :
    * Keyboard (model and numlock)
    * Disable Lock screen delay and power management
    * Audio
    * Trashbin
    * Defaults app
    * Auto-launch app
* Setup softwares :
    * Firefox
    * Seafile client
    * NAPS2
    * Handy
    * Zeditor (with extensions)
* Import configs files :
    * Import keybinds.kksrc
    * Import Kwin Script Kzones
    * Import Ferdium config
    * Import Prusa config
    * Import OBS config
