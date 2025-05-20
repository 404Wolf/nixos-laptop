{pkgs, ...}: {
  # User account
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      wolf = {
        password = "password";
        description = "Wolf Mermelstein";
        extraGroups = ["wheel" "docker" "networkmanager"];
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDqexLCM6mY78L0mtyvS8HUecfuFBfcI4BaMFPk7moYIDISDxVQbvLvXkgJqWfrOgBxBRIjAzdLi5oa0es1LukTPEb1R+MP/FgJeo+CYAgPFGohY+feYU6Am8Md7euSXnzIv4rNkJI/UokkuOfjw7oxFVSbAtJJUFsDEspY1153RkrUidyeQPE5zp9LfLKR4YHgS6z9RQi7yGVX0+VWTBaDi1tUtSxxYn1J4iOd4a2SFzAnRAnw5AMvX66XZFmDFoHU2/iqq4aGE3f08J/WwUIfO6S1uosDB/K1jiJ1lTDEQYuV1g+nQzxzmwwNzl67hq93h82XbMd/wIh6i8yGriEh6uwNvddfhpev4mY0b+WppEHhAqq3wHqdv7WpINQYpcZY6+i70TiW2xyRAM/75HP4JQkj4TESwmB34Nqs8uXXtEbH95w1BLpwdGXTVaPUCZY6gAYGcuicZBDh+QFe2e0D0BronVaEVcWE03UmnPdAjb3tdiwpJ1mgPSVx1FG7h3TXCc50AMR4BCPFt5qxJ1U14ebu5EWlKDCeVJ+zDyYJxXUSKPYdqvSii6gbeddqA/WKt54teQ2eV6kKLfInbevdfjyEIzPAbnvidahntwmNoDRU1IxodXMXbBps9jBWHbxpLLzk0yK+9C8XpyNGU901LGQxMexr5z3W+aBgxIXy7Q== wolf@404wolf.com"
        ];
      };
    };
  };
}
