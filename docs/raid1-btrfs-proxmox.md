# Criar RAID1 via Btrfs no Proxmox

Este documento explica o passo a passo para criar um sistema de arquivos Btrfs com RAID1 no Proxmox, garantindo redundância automática dos dados para backups.

---

## ⚠️ Atenção

- Esta operação **apagará todos os dados** dos discos envolvidos.
- Faça backup de dados importantes antes de continuar.
- Execute os comandos como root para evitar problemas.
- Verifique cuidadosamente os dispositivos antes de formatar.

---

## Passos para criar RAID1 Btrfs

### 1️⃣ Identificar os discos

No Proxmox, execute:

```bash
lsblk
```

Identifique os discos que deseja usar para o RAID1 (exemplo: `/dev/sdb` e `/dev/sdc`).

### 2️⃣ Criar sistema de arquivos Btrfs com RAID1

> ⚠️ Essa operação apagará todos os dados dos discos selecionados.

Execute:

```bash
mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
```

### 3️⃣ Criar ponto de montagem

```bash
mkdir -p /mnt/pbs-backup
mount -o defaults,compress=zstd /dev/sdb /mnt/pbs-backup
```

### 4️⃣ Tornar a montagem permanente

Edite o arquivo `/etc/fstab` e adicione a seguinte linha para montar automaticamente no boot:

```
/dev/sdb /mnt/pbs-backup btrfs defaults,compress=zstd 0 0
```

### 5️⃣ Montar o armazenamento no LXC do Proxmox Backup Server (PBS)

Edite a configuração do container PBS (substitua `100` pelo ID do seu container):

```bash
nano /etc/pve/lxc/100.conf
```

Adicione a linha:

```
mp0: /mnt/pbs-backup,mp=/mnt/backup
```

Reinicie o container:

```bash
pct stop 100 && pct start 100
```

### 6️⃣ Configurar PBS para usar o novo datastore

No painel web do PBS:

- Vá em **Datastore** → **Adicionar Datastore**
- Defina o caminho como `/mnt/backup`

---

Agora seu Proxmox Backup Server está configurado para armazenar backups em um RAID1 com Btrfs, garantindo maior segurança e redundância! 🎉

---

## Referências

- [Btrfs Wiki - RAID](https://btrfs.wiki.kernel.org/index.php/RAID)
- [Proxmox Backup Server Documentation](https://pbs.proxmox.com/docs/)