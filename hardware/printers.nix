{ config, lib, pkgs, modulesPath, ... }:

{
  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    };

  services.printing = {
    enable = true; # CUPS
    drivers = with pkgs; [
      brlaser # Brother's drivers
      cups-brother-dcpl3550cdw
    ];
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother_DCP_L3550CDW";
        location = "Home";
        deviceUri = "dnssd://Brother%20DCP-L3550CDW%20series._ipp._tcp.local/?uuid=e3248000-80ce-11db-8000-3c2af490b8ec";
        model = "brother_dcpl3550cdw_printer_en.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Brother_DCP_L3550CDW";
  };
}