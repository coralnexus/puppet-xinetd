
define xinetd::service (

  $service     = $name,
  $conf_ensure = $xinetd::params::service_conf_ensure,
  $attributes  = {}

) {

  $base_name       = $xinetd::params::base_name
  $definition_name = name("${base_name}_service_${name}")

  $wait     = ensure($attributes['wait'], $attributes['wait'], $xinetd::params::service_wait)
  $protocol = ensure($attributes['protocol'], $attributes['protocol'], $xinetd::params::service_protocol)
  $port     = ensure($attributes['port'], $attributes['port'], $xinetd::params::service_port)

  $config = deep_merge({
      disable         => $xinetd::params::service_disable,
      socket_type     => $xinetd::params::service_socket_type,
      user            => $xinetd::params::service_user,
      group           => $xinetd::params::service_group,
      server          => $xinetd::params::service_server,
      bind            => $xinetd::params::service_bind,
      server_args     => $xinetd::params::service_server_args,
      per_source      => $xinetd::params::service_per_source,
      log_on_failure  => $xinetd::params::service_log_on_failure,
      cps             => $xinetd::params::service_cps,
      flags           => $xinetd::params::service_flags,
      type            => $xinetd::params::service_type,
      instances       => $xinetd::params::service_instances
    },
    $attributes,
    {
      wait     => ensure($wait, $wait, ensure($protocol == 'udp', 'yes', 'no')),
      port     => $port,
      protocol => $protocol
    }
  )

  #-----------------------------------------------------------------------------
  # Configuration

  coral::file { $definition_name:
    resources => {
      path => "${xinetd::params::conf_dir}/${service}",
      ensure  => $conf_ensure,
      content => render($xinetd::params::config_template_class, {
        name       => $service,
        attributes => $config
      }),
      notify  => Service["${base_name}_service"],
    }
  }

  #---

  coral::file_line { $definition_name:
    resources => {
      path   => $xinetd::params::services_listing,
      line   => "${service} ${port}/${protocol} # ${service}",
      match  => "^${service}\s+",
      notify => Service["${base_name}_service"],
    }
  }

  #---

  coral::firewall { $definition_name:
    resources => {
      primary => {
        name  => "${port} INPUT Allow Xinetd connections",
        dport => $port
      }
    },
    defaults => {
      action => 'accept',
      chain  => 'INPUT',
      state  => 'NEW',
      proto  => $protocol
    }
  }
}
