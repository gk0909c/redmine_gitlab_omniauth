require File.expand_path('../../test_helper', __FILE__)

# integration test
class IntegrationTest < ActionDispatch::IntegrationTest
  self.fixture_path = File.dirname(__FILE__) + '/../fixtures'
  fixtures :users, :email_addresses, :settings

  def setup
    super
    Setting.clear_cache
  end

  test 'gitlab auth link is invisible until setting complete' do
    Setting.plugin_redmine_gitlab_omniauth = {}
    get '/login'
    assert_select('div.gitlab-auth', 0)
  end

  test 'gitlab auth button is visible' do
    get '/login'
    assert_select('div.gitlab-auth', count: 1, href: '/auth/gitlab')
  end

  test 'gitlab success callback' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:gitlab,
                             info: {
                               username: 'testuser',
                               name: 'first family',
                               email: 'test@example.com'
                             })
    get_via_redirect('/auth/gitlab')

    assert_equal '/', path
    assert_equal 'testuser', User.current.login
  end

  test 'gitlab failure callback' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:gitlab] = :access_denied
    get_via_redirect('/auth/gitlab')

    assert_equal '/login', path
    assert User.current.is_a?(AnonymousUser)
  end
end
