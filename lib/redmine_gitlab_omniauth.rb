require 'omniauth-gitlab'

# use gitlab-omniauth as middleware
module RedmineGitlabOmniauth
  include AccountHelperPatch

  def use_middleware
    return unless setting_complete?

    setting = Setting['plugin_redmine_gitlab_omniauth']

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
