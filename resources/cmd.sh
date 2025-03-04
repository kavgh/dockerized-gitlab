#!/bin/bash

set -eo pipefail

/usr/bin/wget -O /home/step-cli_amd64.deb https://dl.smallstep.com/cli/docs-cli-install/latest/step-cli_amd64.deb && /usr/bin/dpkg -i /home/step-cli_amd64.deb
/usr/bin/grep fingerprint /defaults.json | /usr/bin/cut -d '"' -f4 | /usr/bin/xargs -i /usr/bin/step-cli ca bootstrap --ca-url https://acme:9000 --fingerprint {} --install
/usr/bin/mkdir -p /etc/gitlab/ssl && /usr/bin/chmod 755 /etc/gitlab/ssl
/usr/bin/step-cli ca certificate --ca-url https://acme:9000 --password-file /password --not-after "5m" localhost /etc/gitlab/ssl/localhost.crt /etc/gitlab/ssl/localhost.key

/usr/sbin/start-stop-daemon -S -b -m -p /var/run/step-cli.pid -x /usr/bin/step-cli -- ca renew --daemon --exec "/opt/gitlab/bin/gitlab-ctl hup nginx" /etc/gitlab/ssl/localhost.crt /etc/gitlab/ssl/localhost.key


/assets/wrapper