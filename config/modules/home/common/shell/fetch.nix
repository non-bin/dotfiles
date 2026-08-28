{
  pkgs,
  ...
}:

let
  fastfetchConfig = pkgs.writeText "fastfetch.json" ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json",
      "display": {
        "disableLinewrap": true
      },
      "modules": [
        "title",
        "separator",
        "os",
        "host",
        "kernel",
        "uptime",
        "packages",
        "shell",
        "display",
        "de",
        "wm",
        "lm",
        "terminal",
        "terminalfont",
        {
          "type": "cpu",
          "temp": true
        },
        {
          "type": "gpu",
          "detectionMethod": "auto",
          "temp": true
        },
        "memory",
        "swap",
        "disk",
        "media",
        {
          "type": "battery",
          "temp": true
        }
      ]
    }
  '';

in
{
  programs.fastfetch = {
    enable = true;
  };
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "xenogender";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
      };
      backend = "fastfetch";
      args = "--config ${fastfetchConfig}";
      pride_month_disable = false;
    };
  };
}
