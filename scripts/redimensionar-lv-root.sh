
---

## 2. Script: `scripts/redimensionar-lv-root.sh`

```bash
#!/bin/bash
# Script para remover LV data e expandir LV root no Proxmox
# Uso: execute como root

set -e

echo "ATENÇÃO: Este script irá remover o volume lógico /dev/pve/data"
read -p "Tem certeza que deseja continuar? (digite YES para prosseguir): " confirm
if [[ "$confirm" != "YES" ]]; then
    echo "Abortando operação."
    exit 1
fi

echo "Removendo LV /dev/pve/data..."
lvremove -f /dev/pve/data

echo "Redimensionando LV root para ocupar todo o espaço livre..."
lvresize -l +100%FREE /dev/pve/root

echo "Redimensionando sistema de arquivos..."
resize2fs /dev/mapper/pve-root

echo "Operação concluída com sucesso!"