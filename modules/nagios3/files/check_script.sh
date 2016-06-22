#!/bin/bash
line_number=`cat /etc/apache2/apache2.conf | wc -l`

usage() {
cat << EOF
Usage: $0 -w <warning> -c <critical>

Script is checking if number of lines in /etc/apache2/apache2.conf is less than critical and warning.

 -w <warning> alert warning state, if the number of lines is less than <warning>.
 -c <critical> alert critical state, if the number of lines is less than <critical>.
 -h show command option

EOF
exit 3
}

# Checking the status, outputting the nagios status code
check_status() {
case $retval in
  0 )
  echo "OK - Line Numbers:$line_number"
  exit 0
  ;;

  1 )
  echo "WARNING - Line Numbers:$line_number"
  exit 1
  ;;

  2 )
  echo "CRITICAL - Line Numbers:$line_number"
  exit 2
  ;;

  3 )
  echo "UNKNOWN - Line Numbers:$line_number"
  exit 3
  ;;

esac
}

while getopts "c:w:h" opt ; do
  case $opt in
  c )
  critical="$OPTARG"
  ;;

  w )
  warning="$OPTARG"
  ;;

  h )
  usage
  ;;

  * )
  usage
  ;;

  esac
done

if [ "$line_number" -le "$critical" ]; then
  retval=2
else
  if [ "$line_number" -le "$warning" ]; then
    retval=1
  else
    retval=0
  fi
fi

check_status
