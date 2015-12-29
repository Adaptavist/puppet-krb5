# == Class: krb5::install
#
# Install kerberos packages supported on this platform.
#
# === Authors
#
# Evgeny Zislis <ezislis@adaptavist.com>
#
# === Copyright
#
# Copyright 2014 Adaptavist Ltd, unless otherwise noted.
#
class krb5::install(
        $absent = false,
    ) {

  case $::operatingsystem {
      'CentOS': { $package = [ 'krb5-libs', 'krb5-workstation', 'pam_krb5' ]  }
      default:            { fail("Unsupported platform: ${::operatingsystem} or version ${::lsbmajdistrelease}") }
    }

  $package_ensure =  $absent ? {
    true  => 'absent',
    false => 'present'
  }
  
  package { $package:
    ensure => $package_ensure
  }
}
