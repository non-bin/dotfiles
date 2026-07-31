{
  config,
  ...
}:

{
  age.secrets.obsidianLiveSync = {
    rekeyFile = ./obsidianLiveSync.age;
    owner = "couchdb";
    group = "couchdb";
  };
  systemd.tmpfiles.rules = [ "d /mnt/appdata/obsidianLiveSync 0755 couchdb couchdb" ];

  services.couchdb = {
    enable = true;
    bindAddress = "0.0.0.0";
    port = 5984;
    databaseDir = "/mnt/appdata/obsidianLiveSync";
    extraConfigFiles = [ config.age.secrets.obsidianLiveSync.path ];
  };

  networking.firewall.allowedTCPPorts = [ 5984 ];

  # Setup:
  # export hostname=http://localhost:5984
  # export username=admin
  # export database=obsidiannotes
  # export password='<DATABASE>'
  # export passphrase='<VAULT>'
  # curl -s https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/couchdb/couchdb-init.sh | bash
  # deno run --minimum-dependency-age=0 --allow-env https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/setup/generate_setup_uri.ts

  # Connect:
  # https://github.com/vrtmrz/obsidian-livesync/blob/main/docs/quick_setup.md
}
