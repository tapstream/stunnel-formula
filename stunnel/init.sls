# -*- coding: utf-8 -*-
# vim: ft=sls
# Init stunnel
{%- from "stunnel/map.jinja" import stunnel with context %}

{%- if stunnel.enabled %}
include:
  - stunnel.install
  - stunnel.config
  - stunnel.service
{%- else %}
'stunnel-formula disabled':
  test.succeed_without_changes
{%- endif %}
