{% from "stunnel/map.jinja" import stunnel with context -%}

stunnel_service:
 service.{{ stunnel.service.state }}:
   - name: {{ stunnel.service.name }}
   - enable: {{ stunnel.service.enable }}
   - watch:
       - file: stunnel_config_file
       - file: stunnel_default_config_file