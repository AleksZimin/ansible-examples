# Version 0.1
# Роль для управления виртуальными машинами. Декларативное описание

# Пример файла с переменными:
pause_in_loops: 5
postfix: "{{ lookup('pipe', 'date +%Y-%m-%d_%H-%M-%S') }}"
postfix: ver-1.0
ignoring_errors: yes
enable_backup: yes    # Применяется при копировании образа ВМ (gold->vm image) и только при выставленном флаге 'force'. 

vms:
  INFRA-I:
    flags: ['recreate', 'start']
    hostname: INFRA-I
    timezone: "Europe/Moscow"
    storage:
      primary:
        size: 30G
        type: xfs
        name: "INFRA-I-{{ postfix }}"
        image_folder: /kvm/vhdd
        gold_image_source: /backup/kvm/INFRA-I_base_2019-02-16.qcow2
    vcpus: 2
    memory: 4096
    graphics:
        vnc:
          port: 5905
    network:
        do_proxy: false            # Enable proxy settings for the new VM. Ensure proxy config is included.
        dchp: true                # Whether to use DHCP
        # Required when not using DHCP
        ip: 192.168.0.211           # IP Address to use
        mask: 24                   # Network Mask Value
        gateway: 192.168.0.1      # Network Gateway
        netmask: 255.255.255.0      # Netmask
        broadcast: 192.168.0.255    # Broadcast address
        #mac: xxx.xxx.xxx.xxx      # MAC Address
        dns: ['192.168.0.201','192.168.0.202']
        #proxy:
          #addr: "address.com"
          #port: "3128"

# Возможные значения флагов:
start
stop
restart
create                            # Создает ВМ. При force перезаписывает существующий образ. Создает бекап предыдущего образа при заданной переменной enable_backup: yes (на данный момент не работает).
                                  # если ВМ существовала, то ее необходимо удалить перед созданием образа
delete                            # Удалаяет ВМ. При force удаляет так же все ее диски
recreate                          # Удалаяет ВМ, затем создает ее снова. При force удаляет так же все ее диски, а затем копирует gold_image
force                             # Используется в сочетании с create, delete, recreate


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
