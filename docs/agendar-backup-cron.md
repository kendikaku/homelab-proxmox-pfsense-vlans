# Agendamento de Backup com Cron

Editar crontab do root:

```bash
crontab -e
```

Adicionar linha para rodar às 2h30 diariamente:

```cron
30 2 * * * /root/backup_proxmox.sh
```