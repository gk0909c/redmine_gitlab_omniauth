require 'omniauth-gitlab'

# use gitlab-omniauth as middleware
module RedmineGitlabOmniauth
  include AccountHelperPatch

  def use_middleware
    return unless setting_complete?

    setting = Setting['plugin_redmine_gitlab_omniauth']

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :gitlab, setting['app_id'], setting['secret'],
               client_options: gitlab_client_options(setting['url'])

      set_on_failure
    end
  end

  private

  def gitlab_client_options(url)
    {
      site: url,
      authorize_url: '/oauth/authorize',
      token_url: '/oauth/token'
    }
  end

  def set_on_failure
    OmniAuth.config.on_failure do |env|
      endpoint = '/auth/gitlab/failure'
      endpoint << "?error_reason=#{env['omniauth.error'].error_reason}"
      [
        302,
        { 'Location' => endpoint, 'Content-Type' => 'text/html' },
        []
      ]
    end
  end
end
