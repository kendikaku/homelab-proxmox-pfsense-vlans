# Configuração do Compartilhamento Samba

Edite o arquivo de configuração do Samba:

```bash
nano /etc/samba/smb.conf
```

Adicione o bloco:

```ini
[Proxmox-Share]
path = /caminho/caminho
browseable = yes
writable = yes
guest ok = no
valid users = japa
create mask = 0664
directory mask = 0775
```

Reinicie o serviço:

```bash
systemctl restart smbd
```