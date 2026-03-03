{ pkgs, ... }:

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
      brlaser # Brother laser drivers
      cups-brother-dcpl3550cdw # Brother laser drivers
      ptouch-driver # Brother P-TOUCH drivers
    ];
  };

  hardware.printers = {
    ensurePrinters = [
      # Brother DCP L3550CDW
      {
        name = "Brother_DCP_L3550CDW";
        location = "Home";
        deviceUri = "dnssd://Brother%20DCP-L3550CDW%20series._ipp._tcp.local/?uuid=e3248000-80ce-11db-8000-3c2af490b8ec";
        model = "brother_dcpl3550cdw_printer_en.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }

      # P-TOUCH CUBE P710BT3815
      # ptouch-print --font "Ubuntu:bold" --fontsize 30 --text "Hello World"
      # https://dominic.familie-radermacher.ch/projekte/ptouch-print/
      {
        name = "PT-P710BT";
        location = "Home";
        deviceUri = "usb://Brother/PT-P710BT?serial=000H8Z943815";
        model = "ptouch-driver/Brother-PT-P710BT-ptouch-pt.ppd.gz";
      }
    ];
    ensureDefaultPrinter = "Brother_DCP_L3550CDW";
  };

  # udev rule to allow USB devices
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="04f9", ATTRS{idProduct}=="20af", MODE="0666"
  '';

  environment.systemPackages = with pkgs; [
    ptouch-print # P-TOUCH CUBE Cli
  ];
}
