{
  security.protectKernelImage = false;

  services.logind = {
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      IdleAction=suspend-then-hibernate
      IdleActionSec=30min
    '';
  };
}
