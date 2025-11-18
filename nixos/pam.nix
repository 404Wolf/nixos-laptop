{
  security.pam.services = {
    sudo.fprintAuth = true;
    login.fprintAuth = true;
    gdm.fprintAuth = true;
    sshd.fprintAuth = true;
    greetd.enableGnomeKeyring = true;
  };
}
