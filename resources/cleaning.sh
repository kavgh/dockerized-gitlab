#!/bin/bash

set -eo pipefail

/usr/bin/docker events --filter 'event=destroy' --filter 'container=git-acme' |

while read events; do
  /usr/bin/rm -rf /home/Unwoven/Projects/Docker/gitlab_server/step/*
  
  /usr/bin/sleep 2
  /usr/bin/rm -rf /home/Unwoven/Projects/Docker/gitlab_server/logs/* /home/Unwoven/Projects/Docker/gitlab_server/data/* \
  /home/Unwoven/Projects/Docker/gitlab_server/data/.* \
  /home/Unwoven/Projects/Docker/gitlab_server/config/ssl /home/Unwoven/Projects/Docker/gitlab_server/config/trusted-certs \
  /home/Unwoven/Projects/Docker/gitlab_server/config/gitlab-secrets.json /home/Unwoven/Projects/Docker/gitlab_server/config/initial_root_password \
  /home/Unwoven/Projects/Docker/gitlab_server/config/ssh_host_ecdsa_key* /home/Unwoven/Projects/Docker/gitlab_server/config/ssh_host_ed25519_key* \
  /home/Unwoven/Projects/Docker/gitlab_server/config/ssh_host_rsa_key*
done