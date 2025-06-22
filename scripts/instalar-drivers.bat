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