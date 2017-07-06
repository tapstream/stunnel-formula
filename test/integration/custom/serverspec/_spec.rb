require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('stunnel4') do
  it { should be_installed }
end

describe file('/etc/stunnel/stunnel.conf') do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /chroot = \/var\/lib\/stunnel4/ }
  its(:content) { should match /setuid = stunnel4/ }
  its(:content) { should match /setgid = stunnel4/ }
  its(:content) { should match /pid = \/var\/run\/stunnel4\/stunnel4.pid/ }
  its(:content) { should match /debug = 5/ }
  its(:content) { should match /cert = \/etc\/pki\/test_ca\/certs\/stunneltest.crt/ }
  its(:content) { should match /key = \/etc\/pki\/test_ca\/certs\/stunneltest.key/ }
  its(:content) { should match /CApath = \/etc\/ssl\/certs/ }
  its(:content) { should match /verify = 3/ }
  its(:content) { should match /sslVersion = TLSv1.2/ }
  its(:content) { should match /ciphers = ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-DSS-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDH-RSA-AES256-GCM-SHA384:ECDH-ECDSA-AES256-GCM-SHA384:AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:DHE-RSA-AES128-GCM-SHA256:ECDH-RSA-AES128-GCM-SHA256:ECDH-ECDSA-AES128-GCM-SHA256:AES128-GCM-SHA256/ }
  its(:content) { should match /options = -NO_SSLv2/ }
  its(:content) { should match /options = -NO_SSLv3/ }
  its(:content) { should match /\[graphite-server\]/ }
  its(:content) { should match /client = no/ }
  its(:content) { should match /accept = localhost:22003/ }
  its(:content) { should match /connect = 127.0.0.1:2003/ }
  its(:content) { should match /\[graphite-client\]/ }
  its(:content) { should match /client = yes/ }
  its(:content) { should match /accept = 127.0.0.1:2003/ }
  its(:content) { should match /connect = localhost:12003/ }
end

describe file('/etc/default/stunnel4') do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /ENABLED=1/ }
end

describe service('stunnel4') do
  it { should be_enabled }
  it { should be_running }
end

describe process("stunnel4") do
  it { should be_running }
  its(:user) { should eq "stunnel4" }
  its(:args) { should match /\/etc\/stunnel\/stunnel.conf/ }
  its(:count) { should eq 1 }
end

describe port(2003) do
  it { should be_listening.on('127.0.0.1').with('tcp') }
end

describe port(22003) do
  it { should be_listening.on('127.0.0.1').with('tcp') }
end
