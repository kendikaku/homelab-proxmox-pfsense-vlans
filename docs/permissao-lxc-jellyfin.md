# Permissões para LXC não privilegiado e Jellyfin

Verificar permissões:

```bash
ls -ld /caminho/caminho
ls -l /caminho/caminho
```

Alterar dono para UID 100107 e GID 100110:

```bash
chown -R 100107:100110 /caminho/caminho
```