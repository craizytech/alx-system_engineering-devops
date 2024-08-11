# This puppet manifest executes a command that kills a killmenow proces
exec { 'kill':
  command  => '/usr/bin/pkill killmenow'
}
