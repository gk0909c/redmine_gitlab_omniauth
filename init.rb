Redmine::Plugin.register :redmine_gitlab_omniauth do
  name 'Redmine Gitlab Omniauth plugin'
  author 'gk0909c'
  description 'Omniauth to gitlab from redmine'
  version '0.0.1'
  url 'https://github.com/gk0909c/redmine_gitlab_omniauth.git'

  settings default: { empty: false },
           partial: 'settings/gitlab_setting'
end

setting = Setting['plugin_redmine_gitlab_omniauth']

unless setting['app_id']
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :gitlab, setting['app_id'], setting['secret'],
             client_options: {
               site: setting['url'],
               authorize_url: '/oauth/authorize',
               token_url: '/oauth/token'
             }
  end
end
