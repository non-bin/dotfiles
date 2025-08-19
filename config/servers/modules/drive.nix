{ config, lib, pkgs, ... }:

{
  imports = [
    # homepage # TODO
  ];

  networking.firewall.allowedTCPPorts = [ 80 ];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "localhost";

    database.createLocally = true;
    configureRedis = true;
    config = {
      adminuser = "admin";
      adminpassFile = "/etc/nextcloud-admin-pass";
      # adminpassFile = "${config.sops.secrets.nextcloud-admin-password.path}"; # TODO https://github.com/firecat53/nixos/blob/3bc032c6f4cc703eedd8c6acaa8ee8a80ea1d4ed/hosts/vps/services/nextcloud.nix
      dbtype = "mysql";
    };
    settings = {
      default_phone_region = "AU";
      mail_smtpmode = "sendmail";
      mail_sendmailmode = "pipe";
      mysql.utf8mb4 = true;
      trusted_domains = ["*"];
      trusted_proxies = ["127.0.0.1"];
    };
    maxUploadSize = "2G"; # also sets post_max_size and memory_limit
    phpOptions = {
      "opcache.interned_strings_buffer" = "16";
    };
  };



  # services.nextcloud = {
  #   enable = true;
  #   package = pkgs.nextcloud31;
  #   hostName = "drive.jacka.net.au";
  #   maxUploadSize = "50G";

  #   config = {
  #     adminpassFile = "/etc/nextcloud-admin-pass";
  #     dbtype = "mysql";
  #   };

  #   configureRedis = true;

  #   # extraApps = {
  #   #   inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
  #   # };

  #   extraAppsEnable = true;
  #   # settings = {
  #   #   mail_smtpmode = "sendmail";
  #   #   mail_sendmailmode = "pipe";
  #   # };
  # };
}
