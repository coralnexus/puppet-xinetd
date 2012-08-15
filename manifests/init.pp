# Class: xinetd
#
# This module manages xinetd
#
# Sample Usage:
#   xinetd::service { 'rsync':
#     port        => '873',
#     server      => '/usr/bin/rsync',
#     server_args => '--daemon --config /etc/rsync.conf',
#  }
#
class xinetd (

  $package         = $xinetd::params::package,
  $package_ensure  = $xinetd::params::package_ensure,
  $service         = $xinetd::params::service,
  $service_ensure  = $xinetd::params::service_ensure,
  $restart_command = $xinetd::params::restart_command,
  $conf_dir        = $xinetd::params::conf_dir,
  $config_file     = $xinetd::params::config_file,
  $config_template = $xinetd::params::config_template,

) inherits xinetd::params {

  #-----------------------------------------------------------------------------
  # Installation

  package { 'xinetd':
    name   => $package,
    ensure => $package_ensure,
  }

  #-----------------------------------------------------------------------------
  # Configuration

  file { 'xinetd-config':
    path    => $config_file,
    content => template($config_template),
    require => Package['xinetd'],
    notify  => Service['xinetd'],
  }

  #-----------------------------------------------------------------------------
  # Services

  service { 'xinetd':
    name    => $service,
    ensure  => $service_ensure,
    enable  => true,
    restart => $restart_command,
    require => [
      Package['xinetd'],
      File['xinetd-config']
    ],
  }
}
