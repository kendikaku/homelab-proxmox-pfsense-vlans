# Docker Stack Multimídia e Infraestrutura

Este repositório contém uma stack Docker Compose que reúne diversos serviços para multimídia, automação, rede e segurança. Todos os serviços estão configurados com volumes externos para persistência, e as variáveis de ambiente estão definidas diretamente no `docker-compose.yml`.

---

## 🚀 Serviços incluídos

- Bazarr, Radarr, Sonarr, Prowlarr (gerenciamento de mídia)
- Jellyfin e Jellyseerr (media server e front-end)
- qBittorrent (cliente torrent)
- Filebrowser (navegador de arquivos via web)
- Code-Server (VS Code em container)
- Vaultwarden (gerenciador de senhas)
- OpenSpeedTest (teste de velocidade)
- Nginx Proxy Manager (proxy reverso e SSL)
- Watchtower (atualização automática dos containers)
- Pi-hole (bloqueador de anúncios e DNS local)
- wg-easy (gerenciamento VPN WireGuard)
- Cloudflare-DDNS (atualização dinâmica de DNS)

---

## 📁 Estrutura de volumes

> **IMPORTANTE:** Os caminhos abaixo são exemplos baseados no meu sistema interno (`/mnt/externo/share`). Ajuste-os conforme a sua estrutura de diretórios local.

| Serviço              | Volume Host                                     | Descrição                      |
|----------------------|------------------------------------------------|-------------------------------|
| Bazarr               | `/mnt/externo/share/configs/BazarrConfig`       | Configurações e dados          |
| Radarr               | `/mnt/externo/share/configs/RadarrConfig`       | Configurações e dados          |
| Sonarr               | `/mnt/externo/share/configs/SonarrConfig`       | Configurações e dados          |
| Prowlarr             | `/mnt/externo/share/configs/ProwlarrConfig`     | Configurações                  |
| Jellyfin             | `/mnt/externo/share/configs/JellyfinConfig`     | Configurações                  |
| Jellyseerr           | `/mnt/externo/share/configs/JellyseerrConfig`   | Configurações                  |
| qBittorrent          | `/mnt/externo/share/configs/qBittorrentConfig`  | Configurações                  |
| Filebrowser          | `/mnt/externo/share/configs/FilebrowserConfig`  | Banco de dados do navegador    |
| Code-Server          | `/mnt/externo/share/configs/Code-ServerConfig`  | Configurações do VS Code       |
| Vaultwarden          | `/mnt/externo/share/configs/VaultConfig/vaultdata` | Dados do gerenciador de senhas |
| Nginx Proxy Manager  | `/mnt/externo/share/configs/NPMConfig/data`     | Dados do Nginx Proxy           |
|                      | `/mnt/externo/share/configs/NPMConfig/letsencrypt` | Certificados SSL Let's Encrypt |
| Pi-hole              | `/mnt/externo/share/configs/PiHoleConfig`       | Configurações e dados DNS      |
| wg-easy              | `/mnt/externo/share/configs/Wg-EasyConfig/etc_wireguard` | Configurações WireGuard        |

---

## 🔧 Como usar

1. Garanta que os diretórios dos volumes estão criados e com permissões corretas no host.

2. Ajuste o arquivo `docker-compose.yml` para refletir os caminhos e configurações da sua máquina.

3. Suba a stack com:

```bash
docker compose up -d
```
Opção 2: Via Portainer (recomendado)
Acesse seu painel do Portainer.

Vá em Stacks > Add stack.

Cole o conteúdo do arquivo docker-compose.yml na área de edição.

Ajuste os volumes e variáveis conforme seu ambiente.

Clique em Deploy the stack.

4. Acesse os serviços nas portas definidas no `docker-compose.yml`. Exemplos:

- Nginx Proxy Manager: `http://<ip-do-host>:81`
- Jellyfin: `http://<ip-do-host>:8096`
- Pi-hole: `http://<ip-do-host>/admin`
- qBittorrent: `http://<ip-do-host>:8080`
- Vaultwarden: `http://<ip-do-host>:10380`
- Code-Server: `http://<ip-do-host>:8443`

---

## ⚠️ Observações

- As portas devem estar livres no host para evitar conflito.
- Variáveis sensíveis (senhas, tokens) podem estar contido no arquivo Compose — adapte com cuidado antes de subir para repositórios públicos.
- Watchtower atualiza automaticamente os containers, facilitando a manutenção.
- Pi-hole pode precisar de configuração extra na rede para funcionar como DNS principal.
- Ajuste as rotas e domínios no Nginx Proxy Manager conforme seu ambiente.

---

## 📚 Referências úteis

- [Docker Compose](https://docs.docker.com/compose/)
- [LinuxServer.io Docs](https://docs.linuxserver.io/)
- [Nginx Proxy Manager](https://github.com/jc21/nginx-proxy-manager)
- [Vaultwarden](https://github.com/dani-garcia/vaultwarden)

---