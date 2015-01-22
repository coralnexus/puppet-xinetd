# Class: xinetd
#
#   This module manages xinetd services.
#
#   Adrian Webb <adrian.webb@coralnexus.com>
#   2013-05-15
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <example/params.json> for Hiera configurations)
#
# Actions:
#
#  Installs, configures, and manages xinetd services.
#
# Requires:
#
# Sample Usage:
#
#   include xinetd
#
class xinetd inherits xinetd::params {

  $base_name = $xinetd::params::base_name

  #-----------------------------------------------------------------------------
  # Installation

  corl::package { $base_name:
    resources => {
      build_packages  => {
        name => $xinetd::params::build_package_names
      },
      common_packages => {
        name    => $xinetd::params::common_package_names,
        require => 'build_packages'
      },
      extra_packages  => {
        name    => $xinetd::params::extra_package_names,
        require => 'common_packages'
      }
    },
    defaults  => {
      ensure => $xinetd::params::package_ensure
    }
  }

  #-----------------------------------------------------------------------------
  # Configuration

  $default_config = render($xinetd::params::config_template_provider, $xinetd::params::config)
  $conf_dir       = $xinetd::params::conf_dir

  corl::file { $base_name:
    resources => {
      config => {
        path    => $xinetd::params::config_file,
        content => template($xinetd::params::config_template),
        notify  => Service["${base_name}_service"]
      }
    }
  }

  #-----------------------------------------------------------------------------
  # Actions

  corl::exec { $base_name: }

  #-----------------------------------------------------------------------------
  # Services

  corl::service { $base_name:
    resources => {
      service => {
        name     => $xinetd::params::service_name,
        ensure   => $xinetd::params::service_ensure,
        restart  => $xinetd::params::restart_command,
        enable   => true,
        provider => 'init'
      }
    },
    require => [ Corl::Package[$base_name], Corl::File[$base_name] ]
  }

  #---

  corl::cron { $base_name:
    require => Corl::Service[$base_name]
  }
}
