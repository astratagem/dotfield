{ lib, pkgs, ... }:
{
  systemd.user.services.ironbar-weather = {
    Unit = {
      Description = "Update ironbar weather widget";
      After = [ "ironbar.service" ];
      Requires = [ "ironbar.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${lib.getExe pkgs.zx} ${./scripts/check-weather.ts}";
    };
  };

  systemd.user.timers.ironbar-weather = {
    Unit = {
      Description = "Update ironbar weather widget every 15 minutes";
    };
    Timer = {
      OnCalendar = "*:0/15";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
