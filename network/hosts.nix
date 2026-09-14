# Homelab inventory.
# Plain data, not a NixOS module: import it from anywhere (NixOS modules and Home-Manager alike) with `import ./network/hosts.nix`.
# Single source of truth for the LAN, so a machine that moves is edited once.

{
  pve      = "192.168.0.100";
  proxy    = "192.168.0.101";
  backup   = "192.168.0.102";
  vault    = "192.168.0.103";
  budget   = "192.168.0.104";
  notes    = "192.168.0.105";
  ai       = "192.168.0.106";
  workflow = "192.168.0.107";
  files    = "192.168.0.110";
  www      = "192.168.0.122";
  media    = "192.168.0.190";
}
