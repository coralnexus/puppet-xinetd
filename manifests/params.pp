
class xinetd::params inherits xinetd::default {

  $base_name = 'xinetd'

  #---

  $build_package_names  = module_array('build_package_names')
  $common_package_names = module_array('common_package_names')
  $extra_package_names  = module_array('extra_package_names')
  $package_ensure       = module_param('package_ensure', 'present')

  #---

  $service_name    = module_param('service_name')
  $service_ensure  = module_param('service_ensure', 'running')
  $restart_command = module_param('restart_command')

  #---

  $config_template_provider = module_param('config_template_provider', 'xinetd')

  $conf_dir        = module_param('conf_dir')
  $config_file     = module_param('config_file')
  $config_template = module_param('config_template')

  $config = module_hash('config', {
    attributes => {
      enabled         => undef,
      disabled        => undef,
      log_type        => [ 'SYSLOG', 'daemon', 'info' ],
      log_on_failure  => 'HOST',
      log_on_success  => [ 'PID', 'HOST', 'DURATION', 'EXIT' ],
      no_access       => undef,
      only_from       => undef,
      max_load        => 2,
      cps             => [ 50, 10 ],
      instances       => 50,
      per_source      => 10,
      v6only          => 'no',
      passenv         => undef,
      groups          => 'yes',
      umask           => '002',
      banner          => undef,
      banner_fail     => undef,
      banner_success  => undef
    }
  })

  $services_listing = module_param('services_listing')

  #---

  $service_conf_ensure     = module_param('service_conf_ensure', 'present')
  $service_port            = module_param('service_port')
  $service_server          = module_param('service_server')
  $service_cps             = module_param('service_cps')
  $service_flags           = module_param('service_flags')
  $service_log_on_failure  = module_param('service_log_on_failure')
  $service_per_source      = module_param('service_per_source')
  $service_server_args     = module_param('service_server_args')
  $service_disable         = module_param('service_disable', 'no')
  $service_socket_type     = module_param('service_socket_type', 'stream')
  $service_protocol        = module_param('service_protocol', 'tcp')
  $service_user            = module_param('service_user', 'root')
  $service_group           = module_param('service_group', 'root')
  $service_instances       = module_param('service_instances', 'UNLIMITED')
  $service_wait            = module_param('service_wait')
  $service_bind            = module_param('service_bind', '0.0.0.0')
  $service_type            = module_param('service_type')
}
