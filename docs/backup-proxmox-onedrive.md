# Script de Backup com Rclone e Telegram

Crie o script:

```bash
nano /root/backup_proxmox.sh
```

Conteúdo:

```bash
#!/bin/bash
PastaBackup="/caminho/caminho"
BackupDestino="onedrive:/backup_proxmox"
DataAtual=$(date +"%Y-%m-%d_%H-%M-%S")

rclone sync $PastaBackup $BackupDestino --progress --create-empty-src-dirs

curl -s -X POST https://api.telegram.org/bot<TOKEN>/sendMessage \
    -d chat_id=<CHAT_ID> \
    -d text="Backup concluído: os arquivos do Proxmox foram enviados para o OneDrive."
```

Torne executável:

```bash
chmod +x /root/backup_proxmox.sh
```