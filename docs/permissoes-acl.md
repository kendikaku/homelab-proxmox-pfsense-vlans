# Permissões ACL para Samba, LXC e Jellyfin

Instalar ACL:

```bash
apt update && apt install acl -y
```

Verificar ACL:

```bash
getfacl /caminho/caminho
```

Aplicar permissões ACL:

```bash
setfacl -m u:usuario:rwx /caminho/caminho
setfacl -R -m u:usuario:rwx /caminho/caminho
setfacl -d -m u:usuario:rwx /caminho/caminho
```

Para LXC e Jellyfin:

```bash
setfacl -R -m u:100107:rwx /caminho/caminho
setfacl -R -m g:100110:rwx /caminho/caminho
setfacl -d -m u:100107:rwx /caminho/caminho
setfacl -d -m g:100110:rwx /caminho/caminho
```