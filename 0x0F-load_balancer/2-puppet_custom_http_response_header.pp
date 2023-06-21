# Install Nginx
package { 'nginx':
  ensure => installed,
}

# Allow HTTP traffic
service { 'ufw':
  ensure => running,
}
exec { 'ufw-allow-http':
  command => 'ufw allow "Nginx HTTP"',
  unless  => 'ufw status | grep "Nginx HTTP"',
}

# Set index page content
file { '/var/www/html/index.nginx-debian.html':
  content => "Holberton School\n",
}

# Add redirection
file_line { 'nginx-redirect':
  path    => '/etc/nginx/sites-available/default',
  line    => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
  match   => 'listen \[::\]:80 default_server;',
  require => Package['nginx'],
}

# Set custom 404 page
file { '/usr/share/nginx/html/custom_404.html':
  content => "Ceci n'est pas une page\n",
}

file_line { 'nginx-404':
  path    => '/etc/nginx/sites-available/default',
  line    => 'error_page 404 /custom_404.html;',
  match   => 'listen \[::\]:80 default_server;',
  require => File['/usr/share/nginx/html/custom_404.html'],
}

file_line { 'nginx-location':
  path    => '/etc/nginx/sites-available/default',
  line    => 'location = /custom_404.html { root /usr/share/nginx/html; internal; }',
  match   => 'error_page 404 /custom_404.html;',
  require => File['/usr/share/nginx/html/custom_404.html'],
}

# Add custom HTTP header response
file_line { 'nginx-header':
  path    => '/etc/nginx/sites-available/default',
  line    => "add_header X-Served-By \$hostname;",
  match   => 'listen \[::\]:80 default_server;',
  require => Package['nginx'],
}

# Restart Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

