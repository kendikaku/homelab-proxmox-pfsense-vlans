# Configuração do Rclone com OneDrive via SSH

No servidor, rode:

```bash
rclone config
```

Na máquina local (cliente), abra o Putty:

- Vá em `Connection > SSH > Tunnels`
- Em `Source Port`: 53682
- Em `Destination`: localhost:53682
- Clique em `Add` e conecte

Copie o link do Rclone para autenticar via navegador local.
