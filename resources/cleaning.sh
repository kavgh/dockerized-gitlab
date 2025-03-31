#!/bin/bash

set -eo pipefail

/usr/bin/docker events --filter 'event=stop' --filter 'name=git-acme' --filter 'name=gitlab' |

while read events; do
  event=$(echo $events | grep -oE stop) #'\b(start|stop)\b')
  name=$(echo $events | grep -oE 'name=(git-acme|gitlab)')
  
  if [[ "$event" == "stop" && "$name" == "name=git-acme" ]]; then
    /usr/bin/sleep 5
    /usr/bin/rm -rf /home/Unwoven/Projects/Docker/gitlab_server/step/*
  elif [[ "$event" == "stop" && "$name" == "name=gitlab" ]]; then
    /usr/bin/sleep 5
    /usr/bin/rm -rf /home/Unwoven/Projects/Docker/gitlab_server/logs/* /home/Unwoven/Projects/Docker/gitlab_server/data/* \
    /home/Unwoven/Projects/Docker/gitlab_server/data/.* \
    /home/Unwoven/Projects/Docker/gitlab_server/config/ssl /home/Unwoven/Projects/Docker/gitlab_server/config/trusted-certs \
    /home/Unwoven/Projects/Docker/gitlab_server/config/gitlab-secrets.json /home/Unwoven/Projects/Docker/gitlab_server/config/initial_root_password \
    /home/Unwoven/Projects/Docker/gitlab_server/config/ssh_host_ecdsa_key* /home/Unwoven/Projects/Docker/gitlab_server/config/ssh_host_ed25519_key* \
    /home/Unwoven/Projects/Docker/gitlab_server/config/ssh_host_rsa_key*
  fi
done