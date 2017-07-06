{% from "stunnel/map.jinja" import stunnel with context %}

stunnel_config_dir:
  file.directory:
    - name: {{ stunnel.conf_dir }}
    - user: root
    - group: root
    - makedirs: True

{% if stunnel.config.chroot_dir is defined and stunnel.config.pid_dir is defined %}
stunnel_pid_dir:
  file.directory:
    - name: {{ stunnel.config.chroot_dir }}{{ stunnel.config.pid_dir }}
    - user: {{ stunnel.config.user }}
    - group: {{ stunnel.config.group }}
    - makedirs: True
{% endif %}

stunnel_config_file:
  file.managed:
    - name: {{ stunnel.conf_dir }}/stunnel.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://stunnel/files/config.j2
    - require:
      - file: stunnel_config_dir

stunnel_default_config_file:
  file.managed:
    - name: {{ stunnel.default }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://stunnel/files/default.j2
