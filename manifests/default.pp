
class xinetd::default {

  case $::operatingsystem {
    debian, ubuntu: {
      $common_package_names = ['xinetd']
      $service_name         = 'xinetd'

      $config_file      = '/etc/xinetd.conf'
      $config_template  = 'xinetd/xinetd.conf.erb'

      $conf_dir         = '/etc/xinetd.d'

      $services_listing = '/etc/services'

      $service_template = 'xinetd/service.erb'
      $restart_command  = '/etc/init.d/xinetd reload'
    }
    default: {
      fail("The xinetd module is not currently supported on ${::operatingsystem}")
    }
  }
}
