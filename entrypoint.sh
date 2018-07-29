#!/bin/bash
# $0 is a script name,
# $1, $2, $3 , ...etc are passed arguments
# $1 is our command
CMD=$1

# set current dir
cd /app

# set stable perl env
source /opt/perlbrew/etc/bashrc
perlbrew use 5.22.0-1.001

# set Mojo params:
export MOJO_MAX_MESSAGE_SIZE=16384   # default is 10485760 (10MB)
export MOJO_MAX_WEBSOCKET_SIZE=8192
export MOJO_MODE

# set default forked process count to 2
FORKS=${HTTP_ECHO_PROCS:=2}

# set default listen port to 3000
LISTEN_PORT=${HTTP_ECHO_PORT:=3000}

case "$CMD" in
  "fork" )
    exec /usr/bin/env perl ./http-echo.pl prefork -w ${FORKS} -l "http://[::]:${LISTEN_PORT}"
    ;;

  "single" )
    export MOJO_MODE=production
    exec /usr/bin/env perl ./http-echo.pl daemon -l "http://[::]:${LISTEN_PORT}"
    ;;

   * )
    # Run custom command. Thanks to this line we can still use
    # "docker run our_image /bin/bash" and it will work
    exec $CMD ${@:2}
    ;;
esac
