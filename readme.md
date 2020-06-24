# Инструкция по использованию

Перед использованием плейбуков и ролей необходимо создать файлы ./ansible.cfg и ./ssh.cfg, используя соответствующие примеры в корне репозитория

## Управление виртуальными машинами

Перед запуском плейбука необходимо создать файл переменных ./environments/KVM_HYPERVISORS/group_vars/KVM_HYPERVISORS.yml, используя соответствующий пример.
Затем выполнить команду для применения конфигурации, указанной в файлах переменных (запускать из директории ansible):

```bash
ansible-playbook -i environments/KVM_HYPERVISORS/inventory.yml playbooks/KVM_HYPERVISORS/main.yml --ask-become-pass --ask-vault-pass
```

## Управление системным ПО

### Запуск плейбуков, которые еще не сделаны в виде ролей

- Установить докер на хостах в infra окружении (перед запуском плейбука необходимо создать файл переменных ./environments/infra/group_vars/docker-hosts.yml)

```bash
ansible-playbook playbooks/docker_tasks/setup_docker_hosts/main.yml -i environments/infra/inventory.yml --ask-become-pass --limit docker-hosts
```

- Установить докер на хостах в dev окружении (перед запуском плейбука необходимо создать файл переменных ./environments/dev/group_vars/docker-hosts.yml)

```bash
ansible-playbook playbooks/docker_tasks/setup_docker_hosts/main.yml -i environments/dev/inventory.yml --ask-become-pass --limit docker-hosts
```

- Установить nginx в ifra окружении (первый параметр скрипта - хост, на который необходимо установить nginx):

```bash
sh play_nginx_main.sh INFRA-I
```

- Установить postgresql 11 для тестов:

```bash
ansible-playbook playbooks/docker_tasks/postgresql/main.yml -i environments/dev/inventory.yml --ask-become-pass --ask-vault-pass --limit TEST-I

ansible-playbook playbooks/docker_tasks/postgresql/main.yml -i environments/dev/inventory.yml --extra-vars '{"container_delete":1}'  --ask-become-pass --limit TEST-I

ansible-playbook playbooks/docker_tasks/postgresql/main.yml -i environments/dev/inventory.yml --extra-vars '{"container_delete":1, "data_delete":1}'  --ask-become-pass --limit TEST-I
```

## Полезные команды и флаги

### Флаги для запуска плейбуков, которые необходимо применить к хостам, не имеющим ssh ключи

```bash
--ask-vault-pass --ask-pass
```

### Команды для работы с Ansible vault

```bash
ansible-vault encrypt environments/dev/credentials.yml
ansible-vault encrypt environments/infra/credentials.yml
ansible-vault encrypt environments/KVM_HYPERVISORS/credentials.yml
ansible-vault encrypt playbooks/docker_tasks/postgresql/credentials.yml

ansible-vault edit
ansible-vault decrypt
```
