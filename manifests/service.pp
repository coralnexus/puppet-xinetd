# Definition: xinetd::service
#
# sets up a xinetd service
# all parameters match up with xinetd.conf(5) man page
#
# Parameters:
#   $port           - required - determines the service port
#   $server         - required - determines the executable for this service
#   $ensure         - optional - defaults to 'present'
#   $cps            - optional
#   $flags          - optional
#   $per_source     - optional
#   $server_args    - optional
#   $log_on_failure - optional - may contain any combination of
#                       'HOST', 'USERID', 'ATTEMPT'
#   $disable        - optional - defaults to 'no'
#   $socket_type    - optional - defaults to 'stream'
#   $protocol       - optional - defaults to 'tcp'
#   $user           - optional - defaults to 'root'
#   $group          - optional - defaults to 'root'
#   $instances      - optional - defaults to 'UNLIMITED'
#   $wait           - optional - based on $protocol
#                       will default to 'yes' for udp and 'no' for tcp
#   $bind           - optional - defaults to '0.0.0.0'
#   $service_type   - optional - type setting in xinetd
#                       may contain any combinarion of 'RPC', 'INTERNAL',
#                       'TCPMUX/TCPMUXPLUS', 'UNLISTED'
#
# Actions:
#   setups up a xinetd service by creating a file in /etc/xinetd.d/
#
# Requires:
#   $server must be set
#   $port must be set
#
# Sample Usage:
#   # setup tftp service
#   xinetd::service { 'tftp':
#     port        => '69',
#     server      => '/usr/sbin/in.tftpd',
#     server_args => '-s $base',
#     socket_type => 'dgram',
#     protocol    => 'udp',
#     cps         => '100 2',
#     flags       => 'IPv4',
#     per_source  => '11',
#   } # xinetd::service
#
define xinetd::service (

  $conf_dir         = $xinetd::params::conf_dir,
  $conf_ensure      = $xinetd::params::service_conf_ensure,
  $port             = $xinetd::params::service_port,
  $server           = $xinetd::params::service_server,
  $cps              = $xinetd::params::service_cps,
  $flags            = $xinetd::params::service_flags,
  $log_on_failure   = $xinetd::params::service_log_on_failure,
  $per_source       = $xinetd::params::service_per_source,
  $server_args      = $xinetd::params::service_server_args,
  $disable          = $xinetd::params::service_disable,
  $socket_type      = $xinetd::params::service_socket_type,
  $protocol         = $xinetd::params::service_protocol,
  $user             = $xinetd::params::service_user,
  $group            = $xinetd::params::service_group,
  $instances        = $xinetd::params::service_instances,
  $wait             = $xinetd::params::service_wait,
  $bind             = $xinetd::params::service_bind,
  $service_type     = $xinetd::params::service_type,
  $service_template = $xinetd::params::service_template,

) {

  #-----------------------------------------------------------------------------

  if $wait {
    $local_wait = $wait
  }
  else {
    $local_wait = $protocol ? {
      udp        => 'yes',
      default    => 'no',
    }
  }

  file { "${conf_dir}/${name}":
    ensure  => $conf_ensure,
    content => template($service_template),
    notify  => Service['xinetd'],
  }
}
