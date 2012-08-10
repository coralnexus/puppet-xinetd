
class xinetd::params {

  include xinetd::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $xinetd_package_ensure  = hiera('xinetd_package_ensure', $xinetd::default::xinetd_package_ensure)
    $xinetd_service_ensure  = hiera('xinetd_service_ensure', $xinetd::default::xinetd_service_ensure)
    $service_port           = hiera('xinetd_service_port', $xinetd::default::service_port)
    $service_server         = hiera('xinetd_service_server', $xinetd::default::service_server)
    $service_ensure         = hiera('xinetd_service_file_ensure', $xinetd::default::service_ensure)
    $service_cps            = hiera('xinetd_service_cps', $xinetd::default::service_cps)
    $service_flags          = hiera('xinetd_service_flags', $xinetd::default::service_flags)
    $service_log_on_failure = hiera('xinetd_service_log_on_failure', $xinetd::default::service_log_on_failure)
    $service_per_source     = hiera('xinetd_service_per_source', $xinetd::default::service_per_source)
    $service_server_args    = hiera('xinetd_service_server_args', $xinetd::default::service_server_args)
    $service_disable        = hiera('xinetd_service_disable', $xinetd::default::service_disable)
    $service_socket_type    = hiera('xinetd_service_socket_type', $xinetd::default::service_socket_type)
    $service_protocol       = hiera('xinetd_service_protocol', $xinetd::default::service_protocol)
    $service_user           = hiera('xinetd_service_user', $xinetd::default::service_user)
    $service_group          = hiera('xinetd_service_group', $xinetd::default::service_group)
    $service_instances      = hiera('xinetd_service_instances', $xinetd::default::service_instances)
    $service_wait           = hiera('xinetd_service_wait', $xinetd::default::service_wait)
    $service_bind           = hiera('xinetd_service_bind', $xinetd::default::service_bind)
    $service_type           = hiera('xinetd_service_ensure', $xinetd::default::service_type)
  }
  else {
    $xinetd_package_ensure  = $xinetd::default::xinetd_package_ensure
    $xinetd_service_ensure  = $xinetd::default::xinetd_service_ensure
    $service_port           = $xinetd::default::service_port
    $service_server         = $xinetd::default::service_server
    $service_ensure         = $xinetd::default::service_ensure
    $service_cps            = $xinetd::default::service_cps
    $service_flags          = $xinetd::default::service_flags
    $service_log_on_failure = $xinetd::default::service_log_on_failure
    $service_per_source     = $xinetd::default::service_per_source
    $service_server_args    = $xinetd::default::service_server_args
    $service_disable        = $xinetd::default::service_disable
    $service_socket_type    = $xinetd::default::service_socket_type
    $service_protocol       = $xinetd::default::service_protocol
    $service_user           = $xinetd::default::service_user
    $service_group          = $xinetd::default::service_group
    $service_instances      = $xinetd::default::service_instances
    $service_wait           = $xinetd::default::service_wait
    $service_bind           = $xinetd::default::service_bind
    $service_type           = $xinetd::default::service_type
  }

  #-----------------------------------------------------------------------------
  # Operating system specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_xinetd_package   = 'xinetd'
      $os_xinetd_service   = 'xinetd'

      $os_config_file      = '/etc/xinetd.conf'
      $os_config_template  = 'xinetd/xinetd.conf.erb'

      $os_conf_dir         = '/etc/xinetd.d'

      $os_service_template = 'xinetd/service.erb'
      $os_restart_command  = '/etc/init.d/xinetd reload'
    }
    default: {
      fail("The xinetd module is not currently supported on ${::operatingsystem}")
    }
  }
}
