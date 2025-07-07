if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt-get update
apt-get upgrade
apt-get autoremove

# Dockge
cd /opt/dockge
docker compose pull && docker compose up -d
