
##=====================================================================##
##======= Disable sending usage statistics sending to gitlab.com ======##
##= https://docs.gitlab.com/administration/settings/usage_statistics/ =##
##=====================================================================##

gitlab_rails['include_optional_metrics_in_service_ping'] = false
gitlab_rails['usage_ping_enabled'] = false

##=================================================##
##================ Configure HTTPS ================##
##= https://docs.gitlab.com/omnibus/settings/ssl/ =##
##=================================================##

external_url "https://localhost"

letsencrypt['acme_staging_endpoint'] = 'https://acme:9000/acme/acme-1/directory'
letsencrypt['acme_production_endpoint'] = 'https://acme:9000/acme/acme-1/directory'
#letsencrypt['alt_names'] = ['192.168.0.28', '*.192.168.0.28']

nginx['redirect_http_to_https'] = true