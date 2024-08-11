# This script kills the process killmenow
exec { 'kill':
  command  => 'pkill -15 killmenow',
  provider => shell
}
