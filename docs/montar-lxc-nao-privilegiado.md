# Montagem de Caminho no LXC Não Privilegiado

Adicione no arquivo de configuração do container:

```bash
nano /etc/pve/lxc/100.conf
```

Adicione a linha:

```ini
mp0: /caminho/original,mp=/caminho/container
```