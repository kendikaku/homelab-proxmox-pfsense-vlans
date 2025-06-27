# Configuração de VLANs e IP Forwarding em VM Docker Debian

Este guia mostra como configurar interfaces VLAN e ativar o encaminhamento de pacotes (`ip_forward`) em uma VM Debian, garantindo comunicação entre containers em diferentes VLANs.

---

## 🔍 Identificar Interface de Rede da VM

Execute dentro da VM:

```bash
ip a
```

Procure a interface que está com status UP e tem IP, como:

```text
2: eth0: <...> inet 192.168.x.x/24 ...
```

> 🧠 Outras possibilidades de nome: `ens18`, `enp0s3`, `eno1`, etc.

---

## 🎯 Criar Interfaces VLAN

> Substitua `eth0` pelo nome da interface detectada acima.

```bash
# VLAN 30
sudo ip link add link eth0 name eth0.30 type vlan id 30

# VLAN 40
sudo ip link add link eth0 name eth0.40 type vlan id 40

# Ativar interfaces
sudo ip link set eth0.30 up
sudo ip link set eth0.40 up
```

---

## ⚙️ Configurar VLANs no Boot (Netplan)

Verifique o gerenciador de rede utilizado:

```bash
ls /etc/netplan/
# ou
systemctl status systemd-networkd
```

> Usando Netplan? Edite o YAML conforme abaixo:

```yaml
network:
  version: 2
  ethernets:
    ens18:
      dhcp4: no
  vlans:
    ens18.30:
      id: 30
      link: ens18
      dhcp4: no
    ens18.40:
      id: 40
      link: ens18
      dhcp4: no
```

> Salve o arquivo (ex: `/etc/netplan/01-netcfg.yaml`) e aplique:

```bash
sudo netplan apply
```

---

## 🚦 Ativar IP Forwarding

Verifique se está ativo:

```bash
sysctl net.ipv4.ip_forward
sysctl net.ipv6.conf.all.forwarding
```

Se o resultado for `= 0`, ative com:

```bash
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

Confirme:

```bash
sysctl net.ipv4.ip_forward
# Deve retornar: net.ipv4.ip_forward = 1
```

---

## ✅ Verificação Final

Cheque as interfaces criadas:

```bash
ip a show eth0
ip a show eth0.30
ip a show eth0.40
```

Se tudo estiver UP e com a configuração certa, missão cumprida! 🚀

---

## Referência

- [Netplan Docs](https://netplan.io/reference/)
- [Debian Wiki VLAN](https://wiki.debian.org/VLAN)