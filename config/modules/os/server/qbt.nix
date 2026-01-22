{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{
  imports = [ ./nginx.nix ];

  age.secrets.qbt.rekeyFile = ./qbt.age;

  services = {
    qbittorrent = {
      enable = true;
      extraArgs = [ "--confirm-legal-notice" ];
      webuiPort = 8081;
      openFirewall = true;
      serverConfig = {
        Application = {
          FileLogger.Age = 1;
          FileLogger.AgeType = 1;
          FileLogger.Backup = true;
          FileLogger.DeleteOld = true;
          FileLogger.Enabled = true;
          FileLogger.MaxSizeBytes = 66560;
          FileLogger.Path = "/config/qBittorrent/logs";
        };
        BitTorrent = {
          Session.AddTorrentStopped = false;
          Session.AlternativeGlobalDLSpeedLimit = 2000;
          Session.AlternativeGlobalUPSpeedLimit = 200;
          Session.BandwidthSchedulerEnabled = true;
          Session.DefaultSavePath = "/mnt/media/downloads/";
          Session.TempPath = "/mnt/media/downloads/incomplete/";
          Session.ExcludedFileNames = "";
          Session.GlobalMaxRatio = 2;
          Session.IgnoreSlowTorrentsForQueueing = true;
          Session.IncludeOverheadInLimits = true;
          Session.MaxActiveDownloads = 50;
          Session.MaxActiveTorrents = 50;
          Session.MaxConnections = 1000;
          Session.MaxConnectionsPerTorrent = 500;
          Session.Port = 6881;
          Session.QueueingSystemEnabled = true;
          Session.SSL.Port = 59533;
          Session.ShareLimitAction = "Stop";
          Session.UseAlternativeGlobalSpeedLimit = true;
        };
        Core = {
          AutoDeleteAddedTorrentFile = "Never";
        };
        LegalNotice = {
          Accepted = true;
        };
        Meta = {
          MigrationVersion = 8;
        };
        Network = {
          PortForwardingEnabled = false;
          Proxy.HostnameLookupEnabled = false;
          Proxy.Profiles.BitTorrent = true;
          Proxy.Profiles.Misc = true;
          Proxy.Profiles.RSS = true;
        };
        Preferences = {
          Connection.PortRangeMin = 6881;
          Connection.UPnP = false;
          Downloads.SavePath = "/mnt/media/downloads/";
          Downloads.TempPath = "/mnt/media/downloads/incomplete/";
          General.Locale = "en";
          MailNotification.req_auth = true;
          Scheduler.end_time = "@Variant(\0\0\0\xf\0\0\0\0)";
          Scheduler.start_time = "@Variant(\0\0\0\xf\x1I\x97\0)";
          WebUI.Address = "*";
          WebUI.AuthSubnetWhitelist = "192.168.0.0/24";
          WebUI.AuthSubnetWhitelistEnabled = true;
          WebUI.LocalHostAuth = false;
          WebUI.Username = user.name;
          WebUI.Password_PBKDF2 = "@ByteArray(QVBiYr3jJsL8JrM1FgvwIg==:1v5zDtA3+zBIYlv2QrWprjUZUoQN6c+A/InOsAwOMz6PARnryyTVOJmdMiSvDt1+N9Ihs3GuK8B4vFLwl3JtnQ==)";
          WebUI.Port = 8081;
          WebUI.ServerDomains = "*";
        };
        RSS = {
          AutoDownloader.DownloadRepacks = true;
          AutoDownloader.SmartEpisodeFilter = ''s(\\d+)e(\\d+), (\\d+)x(\\d+), "(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})", "(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})"'';
        };
      };
    };

    homepage-dashboard = {
      environmentFiles = [ config.age.secrets.sonarr.path ];
      services."Media Backend"."qBittorrent" = {
        icon = "qbittorrent";
        href = "/qbt";
        description = "Torrent downloader";
        siteMonitor = "http://localhost:8081";
        widget = {
          type = "qbittorrent";
          url = "http://localhost:8081";
          username = user.name;
          password = "{{HOMEPAGE_VAR_QBT_PASSWORD}}";
          enableLeechProgress = false; # Download list
        };
      };
    };

    nginx.virtualHosts."${config.networking.fqdnOrHostName}".locations."/qbt/" = {
      proxyPass = "http://localhost:8081/";
    };
  };
}
