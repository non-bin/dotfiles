{
  config,
  ...
}:

{
  age.secrets.obsidianLiveSync.rekeyFile = ./obsidianLiveSync.age;
  systemd.tmpfiles.rules = [ "d /mnt/appdata/obsidianLiveSync 0755 couchdb couchdb" ];

  services.couchdb = {
    enable = true;
    adminPass = builtins.readFile config.age.secrets.obsidian.path;
    databaseDir = "/mnt/appdata/obsidianLiveSync";
  };

  # Setup:
  # export hostname=http://localhost:5984
  # export username=admin
  # export database=obsidiannotes
  # export password=<DBPASSWORD>
  # export passphrase=<VAULTPASSPHRASE>
  # curl -s https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/couchdb/couchdb-init.sh | bash
  # deno run --minimum-dependency-age=0 --allow-env https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/setup/generate_setup_uri.ts

  # Connect:
  # https://github.com/vrtmrz/obsidian-livesync/blob/main/docs/quick_setup.md
}
