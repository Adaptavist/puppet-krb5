define krb5::authenticate::kinit($username, $password) {
  $realm = $name
  exec { "kinit ${username}@${realm}":
    command => "echo '${password}' | kinit ${username}@${realm}",
    unless  => "klist | grep -q '^Default principal: ${username}@${realm}'",
  }
}
