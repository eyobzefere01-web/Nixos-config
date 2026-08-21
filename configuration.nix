{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # GPU & Hardware Acceleration Setup
  hardware.graphics = {
    enable = true;
    enable32Bit = true; 
  };

  # Enable Steam
  programs.steam.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  virtualisation.docker.enable = true;

  # Configure network connections interactively with nmcli or nmtui.
  networking.hostName = "dell";
  networking.networkmanager.enable = true;
  
  # Set your time zone.
  time.timeZone = "America/New_York";

  # hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };	

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound and audio server (PipeWire handles webcams/microphones seamlessly).
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support.
  services.libinput.enable = true;

  # Define a user account.
  users.users.eyob = {
    isNormalUser = true;
    initialPassword = "****";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
   };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # Dev tools
    uv
    curl
    wget
    tree
    vscode-fhs
    antigravity-fhs
    git
    python3
    python3Packages.pip
    gcc
    gnumake
    pkg-config
    mariadb
    postgresql
    sqlite
    qemu
    novnc         
    websockify     
    spice-html5   
    emscripten    
    binaryen  
    wabt  
    wasmtime

    # Desktop apps
    brave
    chromium
    libreoffice-fresh
    kdePackages.okular
    telegram-desktop
    drawio
    gimp
    steam-run

    # Docker CLI tools
    docker-compose

    # hyprland
    waybar
    rofi
    mako
    hyprpaper
    gtklock
    hypridle
    grim
    slurp
    wl-clipboard
    kitty
    xsettingsd
    nwg-look
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      vista-fonts
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font" "Fira Code" "Consolas" ];
      };
    };
  };

  system.stateVersion = "26.05";

}
