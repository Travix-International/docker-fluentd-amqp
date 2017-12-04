#!/bin/bash

# These steps must be executed once the host /var and /lib volumes have
# been mounted, and therefore cannot be done in the docker build stage.

set -e

# inspired by https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86#.k9cjxrx6o

# SIGHUP-handler
sighup_handler() {
  fluentd_pid=$(pgrep fluentd)
  echo "Received SIGHUP, reloading fluentd config with pid $fluentd_pid..."
  kill -SIGHUP "$fluentd_pid"
}

# SIGTERM-handler
sigterm_handler() {
  # stop fluentd
  fluentd_pid=$(pgrep fluentd)
  echo "Received SIGTERM, killing fluentd with pid $fluentd_pid..."
  kill -SIGTERM "$fluentd_pid"
  wait "$fluentd_pid"
  echo "Killed fluentd"
}

# setup handlers
echo "Setting up signal handlers..."
trap 'echo "killing PID ${!}";kill ${!}; echo "executing sighup handler";sighup_handler' 1 # SIGHUP
trap 'echo "killing PID ${!}";kill ${!}; echo "executing sigterm handler";sigterm_handler' 15 # SIGTERM


# start fluentd
echo "Starting fluentd..."
/usr/local/bin/fluentd &


echo "Wait until sigterm_handler stops all background processes - PID ${!}"
while true
do
  tail -f /dev/null & wait ${!}
done
