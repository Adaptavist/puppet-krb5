# == Class: krb5::authenticate
#
# Used to initiate kinit command on multiple domains,
# reads authentication domains and secrets from hiera.
#
# == Parameters:
#
# Hiera example:
#
# krb5::authenticate:
#   EXAMPLE.COM:
#     username: administrator
#     password: verysecret
#   ANOTHER.COM:
#     username: administrator
#     password: confidential
#
# === Usage example:
#
# class { 'krb5::authenticate': }
#   -> class { 'samba::joindomain': }
#
# === Authors:
#
# Evgeny Zislis <ezislis@adaptavist.com>
#
# === Copyright:
#
# Copyright 2014 Adaptavist Ltd, unless otherwise noted
#
class krb5::authenticate {
  $auth_realms = hiera_hash('krb5::authenticate', {})
  validate_hash($auth_realms)
  create_resources('krb5::authenticate::kinit', $auth_realms)
}
