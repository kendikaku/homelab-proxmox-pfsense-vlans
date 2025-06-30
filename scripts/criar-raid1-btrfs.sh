
---

## 2. Script `scripts/criar-raid1-btrfs.sh`

```bash
#!/bin/bash
# Script para criar RAID1 via Btrfs no Proxmox
# ATENÇÃO: Apaga todos os dados dos discos especificados
# Uso: execute como root

set -e

echo "### Criar RAID1 Btrfs no Proxmox ###"
echo "Discos detectados:"
lsblk -d -o NAME,SIZE,MODEL | grep -E 'sd[b-z]'

read -p "Digite os discos para RAID1 separados por espaço (ex: /dev/sdb /dev/sdc): " discos

echo "Você selecionou: $discos"
read -p "Tem certeza que deseja formatar e criar RAID1 nesses discos? DIGITE YES para continuar: " confirm

if [[ "$confirm" != "YES" ]]; then
    echo "Abortando operação."
    exit 1
fi

echo "Formatando discos com Btrfs RAID1..."
mkfs.btrfs -f -d raid1 -m raid1 $discos

PONTO_MONTA=$(pwd)
read -p "Digite o ponto de montagem (ex: /mnt/pbs-backup): " ponto_montagem
mkdir -p "$ponto_montagem"

echo "Montando sistema de arquivos..."
mount -o defaults,compress=zstd "${discos%% *}" "$ponto_montagem"

echo "Adicione esta linha ao /etc/fstab para montagem automática:"
echo "${discos%% *} $ponto_montagem btrfs defaults,compress=zstd 0 0"

echo
echo "Se desejar montar no LXC do PBS, edite /etc/pve/lxc/100.conf e adicione:"
echo "mp0: $ponto_montagem,mp=/mnt/backup"
echo "Depois reinicie o container: pct stop 100 && pct start 100"

echo "Pronto! Configure o PBS para usar /mnt/backup como datastore."