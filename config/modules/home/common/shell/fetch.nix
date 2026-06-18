{ ... }:

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
      args = "-s 'Title:Separator:OS:Host:Kernel:Uptime:Packages:Shell:Display:DE:WM:LM:Terminal:TerminalFont:CPU:GPU:Memory:Swap:Disk:Media:LocalIp:PublicIp:Battery'";
      pride_month_disable = false;
    };
  };
}
