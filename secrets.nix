let
  alice = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlNlKIUyEMf23RugEgJXDMvNY2zDlM3IhONc3/NP4JD9ppoEcUE+JOAl6eVrMox/Q36ZcTHML8BxZfhQoXIGKZWq7ZwFX8pn5SFdNg5OZnY8e/NEEFA/EVOUvP/3L2+Rdkclwz5Rp1UL7Sv5gq98ZzuhxgDZDulDYknd5OGaBHWjrMo1b4Z9li/6aTCs53zl4/38o/TxDGHBiuNDWHtKkdJT47LQ3NVwkh8IP1Id8ZOhoZ0CHimTt0cUg45KLurH2tAU4PxPsaeaSwa6jMjBAY26I/6tadG4ztWlGGqsCYhwCsqCcOH0CRbfKi+qgqHuwa4Sw62fMdhqXl09zPf/VdY3HKdWL0gfyxV3uMTf2OEue6//SiWOJZRQZ9qVpLm5c13+y0A/RXpC3hS8gPvunVkGnj82lxPFrCLx9jYkhvRPLh+eUxwHjUIswFRGgX5vuxEt+0RTGs5jH2CIl5IdviBVWz5GsxcvyqRAuDKu9EkNNawfx1wr//09eBhNMvBw8=";
  users = [ alice ];

  # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
  skellybones = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrLbXquvdKfYVFUJVjIQSigziqRD6o21gVEKYcUNw+G1I7oAAtZ76PpfbCkQxaI7/Ewf770M2i7p4YjzD6ZwzpYlBxVJsDkv62lnSMns9tu6HfrfxE1hhJy6lpsQriBjUW4nj1/KHwnvAH3t9+azvo+RhkoPBURuZjf0jIPRKfOyiZHBo2uZVqtwv2vADtDedntANlv0b1rF/2Trya/ZGVhrgQhf05apGhyfghX6l4NSb5AnExojDLrSOg7H8o8X3k80My8ff/8Rb0czRWclBNAGJX85IkKLLITXzXwADBXrncpPRz4DYKMqY0oZnSn/I9vs8gfascbTEK+PJ8HNgPUPkzbocib7wDHla7FuV/doGGyh99pribH7FQLbhqGk4gpF6u9PpcEUco3qoLgoicStabSc0o7Y1/HPM+9+7o5lXAOwBwfRlvrb272QxEA3zI+KGVg/ZcMPZefLU6CfxEe4BUzyo7Zcmv0Ce/HcaObwDObeOBN67LcN7yJ4N+H9zeCrDAXzOUhp1kdEeS/4r5sLxMz/1tbbtiURCohidh2ga+fXJpaQvm17dcQuRsNffKm8IosB1tNG45AOJ7nCb9tYeoxlWEdKSrM37GrfKSncIZjfdkqV/pWKTiOCGoifttxchdRFAozbzLViQSv78IJceueWpRciCwFlnCnPexJQ==";
  systems = [ skellybones ];

  default = {
    publicKeys = users ++ systems;
    armor = true;
  };
in
{
  "./config/servers/modules/os/qbt.age" = default;
}
