{
  users.cdom.aspects.workstation.home = {
    services.kanshi.settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "workdock";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,638";
          }
          {
            criteria = "LG Electronics LG Ultra HD 0x000668B9";
            status = "enable";
            position = "2520,458";
          }
          {
            criteria = "Acer Technologies CB241Y 0x33340DC8F";
            status = "enable";
            transform = "270";
            position = "1440,0";
          }
        ];
      }
      {
        profile.name = "homedock";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "4000,1090";
          }
          {
            criteria = "LG Electronics LG UltraFine 901NTEPB3220";
            status = "enable";
            position = "1440,550";
          }
          {
            criteria = "LG Electronics LG ULTRAGEAR 107NTBKA5869";
            status = "enable";
            position = "0,0";
          }
        ];
      }
    ];
  };
}
