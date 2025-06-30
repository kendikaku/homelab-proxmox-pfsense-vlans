
# Docker Stack Multimídia e Infraestrutura

Este repositório contém uma stack Docker Compose com diversos serviços para multimídia, automação, rede e segurança. Todos os serviços usam volumes externos para persistência, e as variáveis de ambiente ficam no arquivo `.env`.

> ⚙️ Configuração pensada para rodar em ambiente Proxmox + Debian com armazenamento externo montado em `/mnt/externo/share`.

---

## 🚀 Serviços incluídos

- Bazarr, Radarr, Sonarr, Prowlarr (gerenciamento de mídia)
- Jellyfin, Jellyseerr (media server e front-end)
- qBittorrent (cliente torrent)
- Filebrowser (navegador de arquivos via web)
- Code-Server (VS Code em container)
- Vaultwarden (gerenciador de senhas)
- OpenSpeedTest (teste de velocidade)
- Nginx Proxy Manager (proxy reverso e SSL)
- Watchtower (atualização automática dos containers)
- Pi-hole Unbound (bloqueador de anúncios e DNS local)
- wg-easy (VPN WireGuard)
- Cloudflare-DDNS (atualização dinâmica de DNS)
- FlareSolverr (solver para desafios anti-bot)
- Pairdrop (transferência simples de arquivos via web)
- isponsorblocktv (skip de patrocinadores em vídeos)
- Unifi DB e Network Application (gerenciamento UniFi)
- Heimdall (dashboard de serviços)
- 2FAuth (autenticação de dois fatores)
- Recyclarr (organizador de mídia)

---

## 📁 Estrutura de volumes

Ajuste os caminhos abaixo conforme sua estrutura de diretórios local. Exemplo baseado em `/mnt/externo/share`:

| Serviço                | Volume Host                                     | Descrição                         |
|------------------------|------------------------------------------------|----------------------------------|
| Bazarr                 | `/mnt/externo/share/configs/bazarrconfig`       | Configurações e dados             |
| Radarr                 | `/mnt/externo/share/configs/radarrconfig`       | Configurações e dados             |
| Sonarr                 | `/mnt/externo/share/configs/sonarrconfig`       | Configurações e dados             |
| Prowlarr               | `/mnt/externo/share/configs/prowlarrconfig`     | Configurações                    |
| Jellyfin               | `/mnt/externo/share/configs/jellyfinconfig`     | Configurações                    |
| Jellyseerr             | `/mnt/externo/share/configs/jellyseerrconfig`   | Configurações                    |
| qBittorrent            | `/mnt/externo/share/configs/qbittorrentconfig`  | Configurações                    |
| Filebrowser            | `/mnt/externo/share/configs/filebrowserconfig`  | Banco de dados do navegador      |
| Code-Server            | `/mnt/externo/share/configs/codeserverconfig`   | Configurações do VS Code         |
| Vaultwarden            | `/mnt/externo/share/configs/vaultconfig/vaultdata` | Dados do gerenciador de senhas |
| Nginx Proxy Manager    | `/mnt/externo/share/configs/npmconfig/data`     | Dados do proxy                   |
|                        | `/mnt/externo/share/configs/npmconfig/letsencrypt` | Certificados SSL                |
| Pi-hole Unbound        | `/mnt/externo/share/configs/piholeconfig/etc`   | Configurações e dados DNS        |
|                        | `/mnt/externo/share/configs/piholeconfig/dnsmasq.d` | Configurações DNS               |
| wg-easy                | `/mnt/externo/share/configs/wgeasyconfig/etc_wireguard` | Configurações WireGuard        |
| Flaresolverr           | `/mnt/externo/share/configs/flaresolverrconfig` | Configurações                   |
| Cloudflared            | `/mnt/externo/share/configs/cloudflaredconfig`  | Configurações                   |
| Pairdrop               | `/mnt/externo/share/configs/pairdropconfig`     | Configurações                   |
| isponsorblocktv        | `/mnt/externo/share/configs/isponsorblocktvconfig` | Configurações                 |
| Unifi DB               | `/mnt/externo/share/configs/unificonfig/unifidb`| Banco de dados MongoDB           |
| Unifi Network App      | `/mnt/externo/share/configs/unificonfig`         | Configurações da aplicação UniFi |
| Heimdall               | `/mnt/externo/share/configs/heimdallconfig`      | Configurações                   |
| 2FAuth                 | `/mnt/externo/share/configs/2fauthconfig`        | Dados e banco de dados           |
| Recyclarr              | `/mnt/externo/share/configs/recyclarrconfig`     | Configurações                   |

---

## 🔧 Como usar

1. Crie os diretórios dos volumes no host e ajuste as permissões (ex: `chown -R 1000:1000` e `chmod -R 755`).

2. Atualize o arquivo `.env` com suas variáveis de ambiente (tokens, senhas, URLs).

3. Ajuste os caminhos e configurações do `docker-compose.yml` conforme seu ambiente.

4. Suba a stack com:

```bash
docker compose up -d
```

Ou via Portainer:

- Vá em Stacks > Add stack.
- Cole o conteúdo do `docker-compose.yml`.
- Ajuste variáveis e volumes.
- Clique em Deploy the stack.

5. Acesse seus serviços nas portas configuradas (confira o `docker-compose.yml` para os IPs fixos e portas).

---

## ⚠️ Observações importantes

- Não suba seu `.env` com dados sensíveis para repositórios públicos.
- Certifique-se que as portas usadas estejam livres no host.
- Ajuste firewall e regras de VLAN conforme seu ambiente.
- Watchtower atualiza os containers automaticamente.
- Pi-hole Unbound pode precisar de configurações específicas para DNS.
- Para VPN wg-easy, ajuste as portas no host e firewall.
- MACs fixos facilitam o controle DHCP estático no pfSense.
- Para problemas, confira os logs de cada container via Docker ou Portainer.

---

## 📚 Referências úteis

- [Docker Compose](https://docs.docker.com/compose/)
- [LinuxServer.io Docs](https://docs.linuxserver.io/)
- [Nginx Proxy Manager](https://github.com/jc21/nginx-proxy-manager)
- [Vaultwarden](https://github.com/dani-garcia/vaultwarden)
- [wg-easy](https://github.com/WeeJeWel/wg-easy)

---

**Divirta-se e mantenha seu homelab tinindo!** 🚀