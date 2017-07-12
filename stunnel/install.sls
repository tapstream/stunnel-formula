{% from "stunnel/map.jinja" import stunnel with context -%}
stunnel_package:
  pkg.installed:
    - name: {{ stunnel.package }}
