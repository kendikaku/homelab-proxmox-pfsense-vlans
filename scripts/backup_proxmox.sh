#!/bin/bash

PastaBackup="/caminho/caminho"
BackupDestino="onedrive:/backup_proxmox"
DataAtual=$(date +"%Y-%m-%d_%H-%M-%S")

# Sincroniza os arquivos com o OneDrive via rclone
rclone sync $PastaBackup $BackupDestino --progress --create-empty-src-dirs

# Envia notificação via Telegram
curl -s -X POST https://api.telegram.org/bot<TOKEN>/sendMessage \
    -d chat_id=<CHAT_ID> \
    -d text="Backup concluído: os arquivos do Proxmox foram enviados para o OneDrive em $DataAtual."