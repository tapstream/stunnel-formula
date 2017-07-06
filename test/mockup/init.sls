# states to mockup test environment

mockup_stunnel_install_haveged:
  pkg.installed:
    - name: haveged

mockup_stunnel_pki_dir:
  file.directory:
    - name: /etc/pki

mockup_stunnel_mockup_tls_config:
  file.managed:
    - name: /etc/salt/minion.d/ca.conf
    - contents:
      - "ca.cert_base_path: /etc/pki"

mockup_stunnel_mockup_ssl_create_ca:
  module.run:
    - name: tls.create_ca
    - ca_name: test_ca
    - days: 5
    - CN: MyTestCA
    - C: US
    - ST: MyState
    - L: MyCity
    - O: MyOrgUnit
    - emailAddress: test@example.com
    - unless: test -f /etc/pki/test_ca/test_ca_ca_cert.crt

mockup_stunnel_mockup_ssl_create_csr:
  module.run:
    - name: tls.create_csr
    - ca_name: test_ca
    - CN: stunneltest
    - unless: test -f /etc/pki/test_ca/certs/stunneltest.key

mockup_stunnel_mockup_ssl_sign_csr:
  module.run:
    - name: tls.create_ca_signed_cert
    - ca_name: test_ca
    - CN: stunneltest
    - unless: test -f /etc/pki/test_ca/certs/stunneltest.crt
