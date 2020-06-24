#!/Bin/sh
ansible-playbook playbooks/docker_tasks/nginx/main.yml -i environments/infra/inventory.yml --extra-vars=@playbooks/docker_tasks/nginx/nginx.yml --ask-become-pass --limit $1