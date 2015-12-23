# == Class: krb5::params
#
# Default parameters for kerberos configuration and module code.
#
# === Authors
#
# Evgeny Zislis <ezislis@adaptavist.com>
#
# === Copyright
#
# Copyright 2014 Adaptavist Ltd, unless otherwise noted.
#
class krb5::params {
  $config_file = '/etc/krb5.conf'
  $config_file_mode = '0644'
  $config_file_owner = 'root'
  $config_file_group = 'root'

  $default_options_logging = {
    'default'      => 'FILE:/var/log/krb5libs.log',
    'kdc'          => 'FILE:/var/log/krb5kdc.log',
    'admin_server' => 'FILE:/var/log/kadmind.log'
  }

  $default_options_libdefaults = {
    'allow_weak_crypto'         => undef, # default = false
    'ap_req_checksum_type'      => undef, # default is unset
    # 'canonicalize'              => 'false',
    'ccache_type'               => undef, # default = 4
    'clockskew'                 => undef, # default = 300 # max clock skew 5m
    'default_keytab_name'       => undef, # default = FILE:/etc/krb5.keytab
    'default_realm'             => undef, # unset
    'default_tgs_enctypes'      => undef, # unset = 'aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 des3-cbc-sha1 arcfour-hmac-md5 camellia256-cts-cmac camellia128-cts-cmac des-cbc-crc des-cbc-md5 des-cbc-md4'
    'default_tkt_enctypes'      => undef, # unset = 'aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 des3-cbc-sha1 arcfour-hmac-md5 camellia256-cts-cmac camellia128-cts-cmac des-cbc-crc des-cbc-md5 des-cbc-md4'
    # 'dns_canonicalize_hostname' => 'true',
    'dns_lookup_kdc'            => undef, # default = true
    'dns_lookup_realm'          => undef, # default = false
    'dns_fallback'              => undef,
    'extra_addresses'           => undef, # unset. format: comma separated list of addresses
    'forwardable'               => undef, # default = false
    'ignore_acceptor_hostname'  => undef, # default = false
    'k5login_authoritative'     => undef, # default = true
    'k5login_directory'         => undef, # default ~/.k5login
    # 'kdc_default_options'       => '0x00000010',
    'kdc_timesync'              => undef, # default = non zero value
    'kdc_req_checksum_type'     => undef,
    'noaddresses'               => undef, # default = true
    'permitted_enctypes'        => undef, # unset = 'aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 des3-cbc-sha1 arcfour-hmac-md5 camellia256-cts-cmac camellia128-cts-cmac des-cbc-crc des-cbc-md5 des-cbc-md4'
    'preferred_preauth_types'   => undef, # default = 17, 16, 15, 14
    'proxiable'                 => undef, # default = false
    'rdns'                      => undef, # default = true
    'realm_try_domains'         => undef, # default = -1 # not to search
    'renew_lifetime'            => undef, # default = 0
    'safe_checksum_type'        => undef,
    'ticket_lifetime'           => undef, # default = 1d
    'udp_preference_limit'      => undef,
    'verify_ap_req_nofail'      => undef, # default = false
  }

  $default_options_appdefaults = {
    # 'kinit' => {
    # },
    # 'pam' => {
    # },
    # 'ssh' => {
    # },
    # 'login' => {
    # }
  }

  $default_options_realms = [{
    'EXAMPLE.COM'           => {
      'auth_to_local'       => [ 'DEFAULT' ],
      'auth_to_local_names' => {
        'Administrator' => 'root',
      },
      'admin_server'   => 'kdc.example.com',
      'kdc'            => 'kdc.example.com',
      'kpasswd_server' => undef,
      'master_kdc'     => undef,
    }
  }]

  $default_options_domain_realm = {
    '.example.com' => 'EXAMPLE.COM',
    'example.com'  => 'EXAMPLE.COM'
  }

}
