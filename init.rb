require 'redmine_gitlab_omniauth'
require 'redmine_gitlab_omniauth/hooks'
require 'redmine_gitlab_omniauth/account_helper_patch'
require 'redmine_gitlab_omniauth/application_controller_patch'

Redmine::Plugin.register :redmine_gitlab_omniauth do
  name 'Redmine Gitlab Omniauth plugin'
  author 'gk0909c'
  description 'Omniauth to gitlab from redmine'
  version '0.0.1'
  url 'https://github.com/gk0909c/redmine_gitlab_omniauth.git'

  settings default: { empty: false },
           partial: 'settings/gitlab_setting'
end

include RedmineGitlabOmniauth
use_middleware
