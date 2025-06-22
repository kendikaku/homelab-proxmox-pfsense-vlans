# Adicionar Discos USB a VMs no Proxmox (via ID)

Este documento mostra como adicionar discos USB conectados ao Proxmox diretamente em uma VM utilizando seus identificadores persistentes (`/dev/disk/by-id/...`), garantindo que os dispositivos mantenham a ordem correta mesmo após reinicializações.

---

## 📦 Discos Detectados

Execute o comando `lsblk` para listar os discos conectados:

```bash
lsblk
```

Você pode identificar os discos USB usando:

```bash
ls -l /dev/disk/by-id/ | grep usb
```

Exemplo de saída:

```text
/dev/disk/by-id/usb-exbom_USB_3.0_DD56419883DCC-0:0 -> ../../sdb
/dev/disk/by-id/usb-exbom_USB_3.0_DD202304134B0-0:0 -> ../../sdc
```

---

## 🔗 Passo a Passo

### 1️⃣ Acesse o terminal do Proxmox como root

### 2️⃣ Adicione os discos à VM

Substitua `numerodavm` pelo ID da sua VM (ex: 101):

```bash
qm set numerodavm -scsi1 /dev/disk/by-id/usb-exbom_USB_3.0_DD56419883DCC-0:0
qm set numerodavm -scsi2 /dev/disk/by-id/usb-exbom_USB_3.0_DD202304134B0-0:0
```

> 💡 O uso de `/dev/disk/by-id/` é recomendado porque esses nomes são persistentes mesmo após reboot.

### 3️⃣ Inicie a VM normalmente

Agora os discos estarão disponíveis dentro da máquina virtual como novos dispositivos de armazenamento.

---

## 📝 Observações

- É necessário que a VM esteja **desligada** antes de adicionar os discos.
- O tipo de disco (`scsi`) pode ser alterado para `sata` ou `virtio`, se preferir.
- Você pode verificar os discos dentro da VM com:

```bash
lsblk
# ou
fdisk -l
```

---

## Referência

- [Proxmox VE Wiki - qm set](https://pve.proxmox.com/wiki/Qm)
