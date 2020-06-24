#!/Bin/sh
ansible-playbook playbooks/docker_tasks/setup_docker_hosts/main.yml --ask-become-pass --limit docker-hosts

# ansible-playbook playbooks/docker_tasks/setup_docker_hosts/main.yml -i environments/infra/inventory.yml --ask-become-pass --limit docker-hosts