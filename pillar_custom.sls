stunnel:
  enabled: True
  service:
    name: stunnel4
    state: running
    enable: true
  config:
    chroot_dir: /var/lib/stunnel4
    user: stunnel4
    group: stunnel4
    pid_dir: /var/run/stunnel4
    pid_file: stunnel4.pid
    debug: 5
    cert_dir: /etc/pki/test_ca/certs
    key_dir: /etc/pki/test_ca/certs
    cert: stunneltest.crt
    key: stunneltest.key
    capath: /etc/ssl/certs
    verify: 3
    sslVersion: TLSv1.2
    ciphers: 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-DSS-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDH-RSA-AES256-GCM-SHA384:ECDH-ECDSA-AES256-GCM-SHA384:AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:DHE-RSA-AES128-GCM-SHA256:ECDH-RSA-AES128-GCM-SHA256:ECDH-ECDSA-AES128-GCM-SHA256:AES128-GCM-SHA256'
    options:
      - -NO_SSLv2
      - -NO_SSLv3
    services:
      - name: graphite-server
        accept: localhost:22003
        connect: 127.0.0.1:2003
      - name: graphite-client
        client: 'yes'
        accept: 127.0.0.1:2003
        connect: localhost:12003
