# About Project

The project is about deploying a [GitLab] container on a local machine.
Besides GitLab, there are also [Redis] for caching StepCA for ACME certificate.

# TL;DR

## GitLab

- `DNS_NAME` DNS name of the GitLab
- `REDIS_PASSWORD` Redis password
- `CERT_SANS` Comma separated SANs
- `CERT_EMAIL` Your email address
- `CERT_NOTBEFORE` Period when the certificate validity starts
- `CERT_NOTAFTER` Period when the certificate validity ends

## StepCA

- `DOCKER_STEPCA_INIT_NAME` Name of certificate issuer
- `DOCKER_STEPCA_INIT_DNS_NAMES` DNS names or IPs by which ACME will accept requests, separated by commas
- `DOCKER_STEPCA_INIT_REMOTE_MANAGEMENT` enable [remote provisioner management](https://smallstep.com/docs/step-ca/provisioners#remote-provisioner-management)
- `DOCKER_STEPCA_INIT_PROVISIONER_NAME` a label for the initial admin (JWK) provisioner. Default: "admin"

## Redis

- `REDIS_PASSWORD` Redis password
- `acme_pass` Path to ACME password. Default is `./resources/password`
- `acme_config` Path to ACME config. Default is `./step/config/defaults.json`

# Configuration

## GitLab

In order to configure GitLab container you have to configure DNS name of the GitLab container by specifying `DNS_NAME`, Redis password by specifying `REDIS_PASSWORD`, and Subject Alternative Names separated by comma specifying `CERT_SANS`.

Optionally you can pass your email address to `CERT_EMAIL` for contact information. For declaring time|duration when the certificate validity period starts you can specify `CERT_NOTBEFORE` it must be RFC 3339 format, such as "300ms", "-1.5h" or "2h45m". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h". For declaring time|duration when the certificate validity period ends you can specify `CERT_NOTAFTER` it must be RFC 3339 format, such as "300ms", "-1.5h" or "2h45m". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h".

The certificate is renewing automatically when 2/3 time of validity is left.

## StepCA

For StepCA container we have to specify 2 values, the `DOCKER_STEPCA_INIT_NAME` this will be a name of the issuer of certificates and `DOCKER_STEPCA_INIT_DNS_NAMES` DNS names or IPs separated by commas by wich the ACME will precess requests.

Not mandatory but recommended `DOCKER_STEPCA_INIT_REMOTE_MANAGEMENT` it enables to store the provisioner configuration store in database.

Also we can specify a JWK label for inital admin provisioner `DOCKER_STEPCA_INIT_PROVISIONER_NAME`. The default value is "admin"

## Redis

The Redis container configured as cache register. We have to declare only `REDIS_PASSWORD` in our local machine

## Secrets

The `acme_pass` is a path to a password file for ACME container and GitLab container. By default the path is `./resources/password` and we have to create this file.

The `acme_config` is a path to a default configuration file for ACME container and GitLab container. This file contains the fingerprint of a StepCA container. The default path is `./step/config/defaults.json`

> [!WARNING]
> Because of the default path for `acme_config` isn't created you have to first start `acme` server and after all others