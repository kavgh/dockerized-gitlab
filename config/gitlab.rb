
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

##============================================================##
##====================== Configure Redis =====================##
##= https://docs.gitlab.com/administration/redis/standalone/ =##
##============================================================##

redis['enable'] = false
gitlab_rails['redis_host'] = 'redis'
gitlab_rails['redis_port'] = 6379
gitlab_rails['redis_password'] = "#{ENV['REDIS_PASSWORD']}"