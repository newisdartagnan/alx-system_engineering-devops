file { '/root/.ssh/config':
  ensure  => present,
  content => "Host *\n  PasswordAuthentication no\n  SendEnv LANG LC_*\n  HashKnownHosts yes\n  GSSAPIAuthentication yes\n  GSSAPIDelegateCredentials no\n  IdentityFile ~/.ssh/school\n",
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0644',
}

