# Gerenciamento de Usuários Samba

Adicionar usuário ao sistema:

```bash
adduser usuario
```

Adicionar usuário ao Samba:

```bash
smbpasswd -a usuario
```

Redefinir senha:

```bash
smbpasswd usuario
```