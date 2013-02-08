
class xinetd::params inherits xinetd::default {

  $package                = module_param('package')
  $package_ensure         = module_param('package_ensure')

  $service                = module_param('service')
  $service_ensure         = module_param('service_ensure')
  $restart_command        = module_param('restart_command')

  #---

  $conf_dir               = module_param('conf_dir')
  $config_file            = module_param('config_file')
  $config_template        = module_param('config_template')
  $services_listing       = module_param('services_listing')

  #---

  $service_template           = module_param('service_template')
  $service_conf_ensure        = module_param('service_conf_ensure')
  $service_configure_firewall = module_param('service_configure_firewall')
  $service_service_ports      = module_param('service_service_ports')
  $service_port               = module_param('service_port')
  $service_server             = module_param('service_server')
  $service_cps                = module_param('service_cps')
  $service_flags              = module_param('service_flags')
  $service_log_on_failure     = module_param('service_log_on_failure')
  $service_per_source         = module_param('service_per_source')
  $service_server_args        = module_param('service_server_args')
  $service_disable            = module_param('service_disable')
  $service_socket_type        = module_param('service_socket_type')
  $service_protocol           = module_param('service_protocol')
  $service_user               = module_param('service_user')
  $service_group              = module_param('service_group')
  $service_instances          = module_param('service_instances')
  $service_wait               = module_param('service_wait')
  $service_bind               = module_param('service_bind')
  $service_type               = module_param('service_type')
}
