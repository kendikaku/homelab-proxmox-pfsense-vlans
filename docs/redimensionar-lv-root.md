# Redimensionar LV Root no Proxmox

Este documento explica como liberar espaço removendo um volume lógico (`data`) e redimensionar o volume root (`root`) no volume group `pve`.

---

## Comandos usados

```bash
lvremove /dev/pve/data
lvresize -l +100%FREE /dev/pve/root
resize2fs /dev/mapper/pve-root