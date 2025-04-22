# Установка promtail на ноды

1. имеем список нод, заранее прописываем его в `inventory`

## что нужно доставить

1. ansible (в том числе ansible-vault)
2. создать себе парольный файлик для вольта
3. ключи ssh должны подходить к нодам и работать с ансиблом, проверьте `ansible.cfg`

## что уже есть

1. настроенная для примера роль для установки агентов заббикса с кредами от loki, зашиврованными вольтом

## план работы

1. имеем список нод в инвентаре
2. запущенный сервер loki
3. заполняем `loki-creds.yml` и шифруем `ansible-vault encrypt loki-creds.yml --vault-password-file ~/.ssh/.vault_pass.txt` (само собой у вас уже должен быть `.vault_pass.txt` с парольной строкой внутри)
4. запускаем установку `./install-promtail.sh`

## tweaks

1. для расшифровки используем `ansible-vault decrypt loki-creds.yml --vault-password-file ~/.ssh/.vault_pass.txt`
