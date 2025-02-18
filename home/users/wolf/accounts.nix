{
  osConfig,
  config,
  ...
}: {
  programs.vdirsyncer.enable = true;

  accounts = {
    email = {
      maildirBasePath = "Mail";
      accounts =
        builtins.mapAttrs
        (key: value: (value
          // {
            thunderbird.enable = true;
            neomutt.enable = true;
            notmuch.neomutt.enable = true;
            notmuch.enable = true;
          })) rec {
          primary = {
            primary = true;
            gpg.key = config.my.variables.primary-yubikey-gpg-id;
            flavor = "fastmail.com";
            address = "wolfmermelstein@fastmail.com";
            aliases = ["wolf@404wolf.com"];
            realName = "Wolf Mermelstein";
            passwordCommand = "cat ${osConfig.sops.secrets."accounts/wolfmermelstein_fastmail/app-password".path}";
            thunderbird.perIdentitySettings = id: {
              "mail.identity.id_${id}.useremail" = "wolf@404wolf.com";
            };
            thunderbird.settings = id: {
              "mail.identity.id_${id}.useremail" = "wolf@404wolf.com";
            };
          };
          gmail = {
            flavor = "gmail.com";
            address = "wolfmermelstein@gmail.com";
            realName = "Wolf Mermelstein";
            passwordCommand = "cat ${osConfig.sops.secrets."accounts/wolfmermelstein_gmail/app-password".path}";
          };
          case = {
            flavor = "gmail.com";
            address = "wsm32@case.edu";
            realName = "Wolf Mermelstein";
            imap = {
              host = "imap.gmail.com";
              port = 993;
            };
            smtp = {
              host = "smtp.gmail.com";
              port = 465;
            };
            passwordCommand = "cat ${osConfig.sops.secrets."accounts/wsm32_case/app-password".path}";
          };
          old = {
            flavor = "gmail.com";
            address = "uptothebird@gmail.com";
            realName = primary.realName;
            passwordCommand = "cat ${osConfig.sops.secrets."accounts/wolfmermelstein_gmail/app-password".path}";
          };
        };
    };
  };
}
