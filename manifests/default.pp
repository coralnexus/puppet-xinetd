
class xinetd::default {

  $package_ensure         = 'present'
  $service_ensure         = 'running'
  $service_conf_ensure    = 'present'

  $service_port           = ''
  $service_server         = ''
  $service_cps            = ''
  $service_flags          = ''
  $service_log_on_failure = ''
  $service_per_source     = ''
  $service_server_args    = ''
  $service_disable        = 'no'
  $service_socket_type    = 'stream'
  $service_protocol       = 'tcp'

  $service_user           = 'root'
  $service_group          = 'root'

  $service_instances      = 'UNLIMITED'
  $service_wait           = ''
  $service_bind           = '0.0.0.0'
  $service_type           = ''

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $package          = 'xinetd'
      $service          = 'xinetd'

      $config_file      = '/etc/xinetd.conf'
      $config_template  = 'xinetd/xinetd.conf.erb'

      $conf_dir         = '/etc/xinetd.d'

      $service_template = 'xinetd/service.erb'
      $restart_command  = '/etc/init.d/xinetd reload'
    }
    default: {
      fail("The xinetd module is not currently supported on ${::operatingsystem}")
    }
  }
}
