{config, ...}: {
  systemd.user = {
     services.wallpaper-refresh = {
       Unit = {
         Description = "Echo hello world";
       };

       Service = {
         Type = "oneshot";
         ExecStart = config.my.scripts.wallpaper-refresh;
       };
     };

     timers.wallpaper-refresh = {
       Unit = {
         Description = "Timer for refreshing wallpaper";
       };

       Timer = {
         OnBootSec = "1min";
         OnUnitActiveSec = "6h";
       };

       Install = {
         WantedBy = [ "timers.target" ];
       };
     };
   };

}
