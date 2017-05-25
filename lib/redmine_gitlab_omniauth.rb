require 'omniauth-gitlab'

# use gitlab-omniauth as middleware
module RedmineGitlabOmniauth
  def use_middleware
    setting = Setting['plugin_redmine_gitlab_omniauth']
    return unless setting['app_id']

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :gitlab, setting['app_id'], setting['secret'],
               client_options: {
                 site: setting['url'],
                 authorize_url: '/oauth/authorize',
                 token_url: '/oauth/token'
               }
    end
  end
end
