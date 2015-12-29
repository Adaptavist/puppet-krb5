# == Class: krb5
#
# Install kerberos packages and configure kerberos with configuration
# data from hiera hashes.
#
# More details about configuration is in krb5::config.
#
# === Parameters
#
# [*absent*]
# When set to true, will remove kerberos packages
#
# [*audit_only*]
# When set to true, will not actually change existing configuration file,
# only show the changes which possibly happen to it.
#
# [*template*]
# Used to specify an alternate template instead of the one used by the module.
#
# === Authors
#
# Evgeny Zislis <ezislis@adaptavist.com>
#
# === Copyright
#
# Copyright 2014 Adaptavist Ltd, unless otherwise noted.
#
class krb5(
  $absent = false,
  $audit_only = false,
  $template = 'krb5/krb5.conf.erb',
){
  class { 'krb5::install':
    absent => $absent,
  } ->
  class { 'krb5::config': } ~>
  Class['krb5']
}
