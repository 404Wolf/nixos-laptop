{...}: {
  services.openssh = {
    enable = true;
    settings = {
      AuthorizedKeysFile = "%h/.ssh/authorized_keys";
    };
  };
}
