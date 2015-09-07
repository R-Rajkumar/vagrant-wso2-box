class stratos_base(
  $ensure = 'present',
  $autoupgrade=true,
){

 Exec { path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', ] }

 exec { 'system-update':
      command => 'sudo apt-get update',
 }

  Exec['system-update'] -> Package <| |>

  if ! ($ensure in [ "present", "absent" ]) {
    fail("ensure parameter must be absent or present")
  }

  if ! ("$autoupgrade" in [ 'true', 'false' ]) {
    fail("autoupgrade parameter must be true or false")
  }

# Set local variables based on the desired state
  if $ensure == "present" {
    if $autoupgrade == true {
      $package_ensure = latest
    }
    else {
      $package_ensure = present
    }
  }
  else {
    $package_ensure = absent
  }

  $packages = [
    'nano',
    'curl',
    'wget',
    'zip',
    'unzip',
    'git',
    'tar']

  package { $packages:
    ensure => $package_ensure,
  }

  define printPackages{
    notify { $name:
      message => "Installed package: ${name}",
    }
  }
  printPackages{ $packages: }

}
