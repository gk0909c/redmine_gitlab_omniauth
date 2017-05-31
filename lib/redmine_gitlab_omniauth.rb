require 'omniauth-gitlab'

# use gitlab-omniauth as middleware
module RedmineGitlabOmniauth
  def use_middleware
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :gitlab, setup: omniauth_setup_proc

      set_on_failure
    end
  end

  private

  def omniauth_setup_proc
    setting = Setting.plugin_redmine_gitlab_omniauth

    lambda do |env|
      options = env['omniauth.strategy'].options
      options[:client_id] = setting['app_id']
      options[:client_secret] = setting['secret']
      options[:client_options] = gitlab_client_options(setting['url'])
    end
  end

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
      endpoint << "?error_type=#{env['omniauth.error.type']}"
      [
        302,
        { 'Location' => endpoint, 'Content-Type' => 'text/html' },
        []
      ]
    end
  end
end
