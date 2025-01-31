{
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
            flavor = "fastmail.com";
            address = "wolfmermelstein@fastmail.com";
            aliases = ["wolf@404wolf.com"];
            realName = "Wolf Mermelstein";
            passwordCommand = "rbw get app.fastmail.com -f 'AppPass'";
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
            passwordCommand = "rbw get google-work -f 'AppPass'";
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
            passwordCommand = "rbw get 'wsm32@Case Western Reserve University' -f 'AppPass'";
          };
          old = {
            flavor = "gmail.com";
            address = "uptothebird@gmail.com";
            realName = primary.realName;
            passwordCommand = "rbw get 'google-home' -f 'AppPass'";
          };
        };
    };
  };
}
