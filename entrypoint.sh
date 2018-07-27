#!/bin/bash
# $0 is a script name,
# $1, $2, $3 etc are passed arguments
# $1 is our command
CMD=$1

# set current dir
cd /app

# set stable perl env
source /opt/perlbrew/etc/bashrc
perlbrew use 5.22.0-1.001

# set Mojo params:
export HTTP_ECHO_PORT
export MOJO_MAX_MESSAGE_SIZE=16384   # default is 10485760 (10MB)
export MOJO_MAX_WEBSOCKET_SIZE=8192

# set default forked process count
FORKS=${HTTP_ECHO_PROCS:=2}  # default to 2 if not set

case "$CMD" in
  "dev" )
    export MOJO_MODE=development
    exec /usr/bin/env perl ./http-echo.pl daemon -l "http://*:${HTTP_ECHO_PORT}"
    ;;

  "single" )
    # we can modify files here, using ENV variables passed in
    # "docker create" command. It can't be done during build process.
    export MOJO_MODE=production
    exec /usr/bin/env perl ./http-echo.pl daemon -l "http://*:${HTTP_ECHO_PORT}"
    ;;

  "fork" )
    export MOJO_MODE=production
    exec /usr/bin/env perl ./http-echo.pl prefork -w ${FORKS} -l "http://*:${HTTP_ECHO_PORT}"
    ;;

   * )
    # Run custom command. Thanks to this line we can still use
    # "docker run our_image /bin/bash" and it will work
    exec $CMD ${@:2}
    ;;
esac
