{
  aspects.hardware__acer__CB241Y.nixos = {
    # diag = w: h: sqrt(w^2 + h^2);
    # diagPx = diag 1920 1080;        => 4405.814340165
    # diagIn = 27;
    # ppi = diagPx / diagIn;          => 163.178308895
    #
    # source:
    # https://www.calculatorsoup.com/calculators/technology/ppi-calculator.php

    services.xserver.dpi = 82;

    # Output "Acer Technologies CB241Y 0x3340DC8F" (HDMI-A-1)
    # Current mode: 1920x1080 @ 74.973 Hz (preferred)
    # Variable refresh rate: not supported
    # Physical size: 530x300 mm
    # Logical position: 1440, 0
    # Logical size: 1080x1920
    # Scale: 1
    # Transform: 270° counter-clockwise
    # Available modes:
    #   1920x1080@74.973 (current, preferred)
    #   1920x1080@60.000
    #   1920x1080@60.000
    #   1920x1080@59.940
    #   1920x1080@50.000
    #   1680x1050@59.883
    #   1280x1024@60.020
    #   1440x900@59.901
    #   1280x800@59.910
    #   1152x864@75.000
    #   1280x720@60.000
    #   1280x720@60.000
    #   1280x720@59.940
    #   1280x720@50.000
    #   1024x768@70.069
    #   1024x768@60.004
    #   800x600@60.317
    #   800x600@56.250
    #   720x576@50.000
    #   720x576@50.000
    #   720x576@50.000
    #   720x480@60.000
    #   720x480@60.000
    #   720x480@59.940
    #   720x480@59.940
    #   720x480@59.940
    #   640x480@66.667
    #   640x480@60.000
    #   640x480@59.940
    #   640x480@59.940
    #   720x400@70.082
    environment.etc."sway/config".text = ''
      set $disp_lg_27ud88w DVI-I-1

      output $disp_lg_27ud88w scale 2
    '';
  };
}
