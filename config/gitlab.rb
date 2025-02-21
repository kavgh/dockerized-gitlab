external_url "https://192.168.0.28"

external_url "http://192.168.0.28"

##=====================================================================##
##======= Disable sending usage statistics sending to gitlab.com ======##
##= https://docs.gitlab.com/administration/settings/usage_statistics/ =##
##=====================================================================##

gitlab_rails['include_optional_metrics_in_service_ping'] = false
gitlab_rails['usage_ping_enabled'] = false