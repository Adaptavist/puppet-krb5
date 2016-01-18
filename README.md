# krb5
[![Build Status](https://travis-ci.org/Adaptavist/puppet-krb5.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-krb5)

Install and configure kerberos krb5 on CentOS Linux.

## Configuration

 Parameter defaults are in krb5::params
 
 Hiera parameters reside in 3 hashes,
   krb5::options - for libdefaults, appdefaults, logging
   krb5::realms  - definition of realm specific parameters
   krb5::domain_realm - mapping of domains to realms

 Hiera example:

```
 krb5::options:
   libdefaults:
     default_realm: 'EXAMPLE.COM'
     rdns: false
   appdefaults:
     telnet
       'EXAMPLE.COM':
         'option1': 'value1',
         'option2': 'value2'
   logging:
     default:      'FILE:/var/log/krb5libs.log'
     kdc:          'FILE:/var/log/krb5kdc.log'
     admin_server: 'FILE:/var/log/kadmind.log'

 krb5::realms:
   - EXAMPLE.COM:
        note the indent, must be 4 spaces under realm name
       domain: 'example.com'
       admin_server: 'ad1.example.com'
       kpasswd_server: 'kdc.example.com'
       kdc:
         - 'kdc1.example.com'
         - 'kdc2.example.com'
   - ANOTHER.COM:
       domain: 'another.com'

  krb5::domain_realm:
    '.example.com': 'EXAMPLE.COM'
    'example.com': 'EXAMPLE.COM'
    '.another.com': 'ANOTHER.COM'
    'another.com': 'ANOTHER.COM'
```

## Usage example:

 Used by the 'krb5' module's init manifest.

```
 class { 'krb5': }

   - or -

 include krb5
```

