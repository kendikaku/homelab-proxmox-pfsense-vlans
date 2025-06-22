# Configurar NIC para Passthrough no Proxmox (VFIO)

Este guia documenta o processo de passar interfaces de rede físicas (NICs) diretamente para VMs no Proxmox usando VFIO. Isso permite que a VM controle diretamente a placa de rede, útil para desempenho ou virtualizações específicas como firewalls (ex: pfSense, OPNsense).

> 🧠 Este tutorial usa valores de exemplo para placas Intel (1Gb e 2.5Gb). Você deve identificar o **ID real da sua NIC** com `lspci`.

---

## 📋 Pré-requisitos

- VT-d/IOMMU ativado na BIOS
- Proxmox com acesso root
- Kernel com suporte a VFIO (padrão no Proxmox 6+)

---

## 🔍 1. Identificar sua placa de rede

Use o comando `lspci` para localizar suas interfaces:

```bash
lspci | grep -i ethernet
```

Depois, identifique o ID de dispositivo e fabricante:

```bash
lspci -n -s 02:00.0
lspci -n -s 00:1f.6
```

Exemplo de saída:

```
02:00.0 0200: 8086:15f3 (rev 03)  # 2.5Gb
00:1f.6 0200: 8086:1a1c (rev 11)  # 1Gb
```

---

## ⚙️ 2. Configurar o Kernel para ativar o IOMMU

Edite o GRUB:

```bash
nano /etc/default/grub
```

Altere a linha para incluir os parâmetros IOMMU:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"
```

Atualize o GRUB:

```bash
update-grub
```

---

## 📦 3. Carregar módulos VFIO no boot

Adicione os seguintes módulos ao `/etc/modules`:

```bash
echo -e "vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd" >> /etc/modules
```

---

## 🧩 4. Atribuir os IDs ao VFIO

Crie ou edite o arquivo:

```bash
nano /etc/modprobe.d/vfio.conf
```

Adicione:

```
options vfio-pci ids=8086:1a1c,8086:15f3
```

---

## 🚫 5. Prevenir conflito com drivers padrão

Crie ou edite o arquivo:

```bash
nano /etc/modprobe.d/blacklist.conf
```

Adicione:

```
blacklist e1000e  # para NIC 1Gb
blacklist igc     # para NIC 2.5Gb
```

---

## 🔄 6. Atualizar initramfs

Execute:

```bash
update-initramfs -u -k all
```

---

## ✅ 7. Reinicie o servidor

```bash
reboot
```

Depois do reboot, verifique se o driver VFIO está sendo usado:

```bash
lspci -nnk -d 8086:15f3
lspci -nnk -d 8086:1a1c
```

Saída esperada:

```
Kernel driver in use: vfio-pci
```

---

## 📌 Observações

- Certifique-se de que sua NIC está isolada em um grupo IOMMU.
- O uso de `vfio-pci` impede o Proxmox de usar a NIC, portanto conectividade pode ser perdida após reboot se a NIC for sua única interface.
- Ideal para NICs dedicadas ao passthrough de VMs como pfSense.

---

## Referências

- [Proxmox Wiki - PCI Passthrough](https://pve.proxmox.com/wiki/PCI_Passthrough)
- [Arch Wiki - VFIO](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF)
