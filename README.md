# Деплой приложения Redmine

### Hexlet tests and linter status:
[![Actions Status](https://github.com/GrandLaite/devops-for-developers-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/GrandLaite/devops-for-developers-project-76/actions)
![CI](https://github.com/GrandLaite/devops-for-developers-project-76/actions/workflows/ci.yml/badge.svg)

Ansible-проект: подготовка двух серверов (pip + Docker), деплой приложения
[Redmine](https://hub.docker.com/_/redmine) в Yandex Cloud за балансировщиком,
общая управляемая БД PostgreSQL и мониторинг через Datadog.

**Приложение:** http://gogopythonhexlet.space:3000

## Требования

| Зависимость | Версия    |
|-------------|-----------|
| Ansible     | >= 2.15   |
| make        | любая     |
| Python      | >= 3.10   |

Дополнительно: SSH-ключ `~/.ssh/yc_key` для доступа к серверам и файл
`.vault_pass.txt` с паролем Ansible Vault в корне проекта (см. «Секреты»).

## Установка зависимостей

Сторонние роли и коллекции (`geerlingguy.pip`, `geerlingguy.docker`,
`datadog.datadog`, `community.docker`) описаны в `requirements.yml`:

```bash
make install
```

## Подготовка серверов

Устанавливает pip и Docker (тег `setup`):

```bash
make prepare
```

## Деплой

Запускает только приложение, без изменения настроек серверов (тег `deploy`):

```bash
make deploy
```

Плейбук создаёт `.env` из шаблона `templates/redmine.env.j2` и поднимает контейнер
Redmine с `env_file` и публикацией порта `redmine_port` (3000). Балансировщик
пробрасывает этот порт на ВМ по IP и домену.

## Мониторинг

Агент Datadog ставится **только на группу `webservers`** (тег `monitoring`),
интеграция `http_check` следит за доступностью приложения:

```bash
make monitoring
```

## Секреты (Ansible Vault)

Все секреты зашифрованы в `group_vars/webservers/vault.yml` и подключаются из
`vars.yml` ссылками `{{ vault_* }}`. Пароль Vault — в `.vault_pass.txt`
(в `.gitignore`, в репозиторий не попадает). В CI задаётся секретом
`ANSIBLE_VAULT_PASSWORD`.

```bash
make secrets-view
make secrets-edit
```

## Тесты

Проверка синтаксиса плейбука и линтинг (та же команда выполняется в CI):

```bash
make lint
```

## Переменные

| Где                          | Что |
|------------------------------|-----|
| `group_vars/all.yml`         | общие несекретные переменные (для группы `all`) |
| `group_vars/webservers/vars.yml`  | переменные деплоя и мониторинга (`redmine_*`, `datadog_*`) |
| `group_vars/webservers/vault.yml` | секреты, зашифрованы Ansible Vault |

## Структура

```
.
├── .github/workflows/ci.yml
├── ansible.cfg
├── inventory.ini
├── playbook.yml
├── requirements.yml
├── Makefile
├── group_vars/
│   ├── all.yml
│   └── webservers/{vars.yml, vault.yml}
└── templates/redmine.env.j2
```
