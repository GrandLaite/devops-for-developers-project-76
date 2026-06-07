# Деплой

### Hexlet tests and linter status:
[![Actions Status](https://github.com/GrandLaite/devops-for-developers-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/GrandLaite/devops-for-developers-project-76/actions)
![CI](https://github.com/GrandLaite/devops-for-developers-project-76/actions/workflows/ci.yml/badge.svg)

Деплой приложения в Yandex Cloud, БД PostgreSQL и мониторинг через Datadog.

**Приложение:** http://gogopythonhexlet.space:3000

## Требования

| Зависимость | Версия    |
|-------------|-----------|
| Ansible     | >= 2.15   |
| make        | любая     |
| Python      | >= 3.10   |

## Установка зависимостей

```bash
make install
```

## Подготовка серверов

Устанавливает pip и Docker

```bash
make prepare
```

## Деплой

```bash
make deploy
```

## Мониторинг

```bash
make monitoring
```

## Тесты

Проверка синтаксиса плейбука и линтинг

```bash
make lint
```

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
