
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

external_url "https://#{ENV['DNS_NAME']}"

nginx['redirect_http_to_https'] = true

letsencrypt['enable'] = false