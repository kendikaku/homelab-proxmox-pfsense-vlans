#!/bin/bash
# Script para configurar VFIO passthrough de NICs no Proxmox
# ATENÇÃO: Use com cuidado. Recomendado apenas para usuários que entendem os riscos.

echo "=== Configurador de VFIO Passthrough de NICs no Proxmox ==="
echo "⚠️  AVISO: Verifique se você tem outra interface de rede ativa antes de continuar!"
echo

read -p "Deseja continuar? (s/n): " confirm
if [[ "$confirm" != "s" ]]; then
  echo "Operação cancelada."
  exit 0
fi

echo
echo "🔍 Listando interfaces de rede detectadas:"
lspci | grep -i ethernet

echo
echo "💡 Copie os IDs dos dispositivos (ex: 8086:1a1c) a serem passados por VFIO."

read -p "Digite os IDs separados por vírgula (ex: 8086:1a1c,8086:15f3): " ids

# Etapa 1: Configurar GRUB
echo "➡️  Atualizando GRUB..."
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"/' /etc/default/grub
update-grub

# Etapa 2: Módulos VFIO
echo "➡️  Adicionando módulos VFIO..."
echo -e "vfio\nvfio_iommu_type1\nvfio_pci\nvfio_virqfd" >> /etc/modules

# Etapa 3: Criar vfio.conf
echo "➡️  Criando /etc/modprobe.d/vfio.conf..."
echo "options vfio-pci ids=${ids}" > /etc/modprobe.d/vfio.conf

# Etapa 4: Blacklist de drivers
echo "➡️  Adicionando blacklist para drivers comuns..."
cat <<EOF >> /etc/modprobe.d/blacklist.conf
blacklist e1000e
blacklist igc
EOF

# Etapa 5: Atualizar initramfs
echo "🔄 Atualizando initramfs..."
update-initramfs -u -k all

echo
echo "✅ Configuração concluída."
echo "⚠️  Reinicie o servidor manualmente para aplicar as mudanças:"
echo "    reboot"