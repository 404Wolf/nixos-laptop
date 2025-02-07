{
  security.pam.services = {
    sudo.fprintAuth = true; # for sudo
    login.fprintAuth = true; # for login
    gdm.fprintAuth = true; # for GDM
  };
}
