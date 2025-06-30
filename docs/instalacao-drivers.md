# Script de Instalação Automática de Drivers no Windows

Este guia documenta o processo de instalação automática de drivers no Windows 10/11 usando um script batch. O método é ideal para reinstalações rápidas após formatação do sistema.

> 🚨 Atenção: No Windows 10 o script usa apenas a pasta C:\Drivers fixa. No Windows 11 você pode usar a função nativa de adição de drivers.

---

## 📋 Pré-requisitos

- Windows 10 ou 11 (com direitos administrativos)
- Drivers no formato .inf organizados na pasta correta
- Execução como administrador

---

## 🔍 1. Preparar a estrutura de pastas

Crie a pasta para os drivers:

```bash
Criar para C:\Drivers no disco C:
```

Organize seus drivers na estrutura:

```
Copiar os drives para a pasta C:\Drivers
```

---

## ⚙️ 2. Criar o script de instalação

Crie um novo arquivo chamado instalar_drivers.bat com o conteúdo:

```bash
@echo off
:: Verifica se a pasta C:\Drivers existe
if not exist "C:\Drivers" (
    echo A pasta C:\Drivers não foi encontrada.
    echo Certifique-se de que os drivers estejam em C:\Drivers e tente novamente.
    pause
    exit /b
)

:: Mostra lista de drivers disponíveis
echo Drivers encontrados para instalação:
dir /s /b C:\Drivers\*.inf

:: Instala os drivers usando pnputil
echo Instalando todos os drivers da pasta C:\Drivers...
pnputil /add-driver "C:\Drivers\*.inf" /subdirs /install

:: Verifica o resultado
if %errorlevel% equ 0 (
    echo Todos os drivers foram instalados com sucesso!
) else (
    echo Ocorreu um erro durante a instalação.
    echo Verifique os logs do pnputil para detalhes.
)

pause
exit
```

---

## 🛠️ 3. Executar o script

Clique com o botão direito no arquivo .bat

Selecione "Executar como administrador"

Acompanhe o processo no prompt

---

## 🔄 4. Verificar drivers instalados (Opcional)

Para confirmar os drivers instalados:

```bash
pnputil /enum-drivers
```

Ou verifique no Gerenciador de Dispositivos.

---

## 📌 Observações importantes

Windows 10:

- Não permite selecionar outra pasta (fixo em C:\Drivers)

- Requer organização manual dos drivers

Windows 11:

- Possui função nativa no Gerenciador de Dispositivos

- Permite selecionar pasta manualmente via interface gráfica

- Para desinstalar drivers problemáticos:

```bash
pnputil /delete-driver <INF_name> /uninstall
```

---

## Referências

- [Documentação Microsoft - PnPUtil](https://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/pnputil)
