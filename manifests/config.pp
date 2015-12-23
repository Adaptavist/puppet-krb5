# == Class: krb5::config
#
# Used to create a configuration file for kerberos.
#
# === Parameters:
#
# Parameter defaults are in krb5::params
# Hiera parameters reside in 3 hashes,
#   krb5::options - for libdefaults, appdefaults, logging
#   krb5::realms  - definition of realm specific parameters
#   krb5::domain_realm - mapping of domains to realms
#
# Hiera example:
#
# krb5::options:
#   libdefaults:
#     default_realm: 'EXAMPLE.COM'
#     rdns: false
#   appdefaults:
#     telnet
#       'EXAMPLE.COM':
#         'option1': 'value1',
#         'option2': 'value2'
#   logging:
#     default:      'FILE:/var/log/krb5libs.log'
#     kdc:          'FILE:/var/log/krb5kdc.log'
#     admin_server: 'FILE:/var/log/kadmind.log'
#
# krb5::realms:
#   - EXAMPLE.COM:
#       # note the indent, must be 4 spaces under realm name
#       domain: 'example.com'
#       admin_server: 'ad1.example.com'
#       kpasswd_server: 'kdc.example.com'
#       kdc:
#         - 'kdc1.example.com'
#         - 'kdc2.example.com'
#   - ANOTHER.COM:
#       domain: 'another.com'
#
#  krb5::domain_realm:
#    '.example.com': 'EXAMPLE.COM'
#    'example.com': 'EXAMPLE.COM'
#    '.another.com': 'ANOTHER.COM'
#    'another.com': 'ANOTHER.COM'
#
# === Usage example:
#
# Used by the 'krb5' module's init manifest.
#
# class { 'krb5': }
#
#   - or -
#
# include krb5
#
# === Authors:
#
# Evgeny Zislis <ezislis@adaptavist.com>
#
# === Copyright:
#
# Copyright 2014 Adaptavist Ltd, unless otherwise noted
#
class krb5::config inherits krb5::params {

  $hiera_options = hiera_hash('krb5::options', {})

  if has_key($hiera_options, 'logging') {
    $manage_options_logging = merge($krb5::params::default_options_logging, $hiera_options['logging'])
  } else {
    $manage_options_logging = $krb5::params::default_options_logging
  }

  if has_key($hiera_options, 'libdefaults') {
    $manage_options_libdefaults = merge($krb5::params::default_options_libdefaults, $hiera_options['libdefaults'])
  } else {
    $manage_options_libdefaults = $krb5::params::default_options_libdefaults
  }

  if has_key($hiera_options, 'appdefaults') {
    $manage_options_appdefaults = merge($krb5::params::default_options_appdefaults, $hiera_options['appdefaults'])
  } else {
    $manage_options_appdefaults = $krb5::params::default_options_appdefaults
  }

  $hiera_realms = hiera_array('krb5::realms', undef)
  if is_array($hiera_realms) {
    $manage_options_realms = $hiera_realms
    $hiera_domain_realm = hiera_hash('krb5::domain_realm', undef)
    if is_hash($hiera_domain_realm) {
      $manage_options_domain_realm = $hiera_domain_realm
    } else {
      $manage_options_domain_realm = $krb5::params::default_options_domain_realm
    }
  } else {
    $manage_options_realms = $krb5::params::default_options_realms
    $manage_options_domain_realm = $krb5::params::default_options_domain_realm
  }

  $manage_file = $krb5::absent ? {
    true    => 'absent',
    default => 'present',
  }
  $manage_audit = $krb5::audit_only ? {
    true  => 'all',
    false => undef,
  }
  $manage_file_replace = $krb5::audit_only ? {
    true  => false,
    false => true,
  }

  file { 'krb5.conf':
    ensure  => $manage_file,
    content => template($krb5::template),
    path    => $krb5::params::config_file,
    mode    => $krb5::params::config_file_mode,
    owner   => $krb5::params::config_file_owner,
    group   => $krb5::params::config_file_group,
    audit   => $manage_audit,
    replace => $manage_file_replace,
  }
}
