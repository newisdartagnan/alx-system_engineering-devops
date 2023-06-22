file { '/home/ubuntu/.ssh/config':
  ensure  => present,
  content => "Host *\n  IdentityFile ~/.ssh/school\n  PasswordAuthentication no\n",
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0644',
}

