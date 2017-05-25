require File.expand_path('../../test_helper', __FILE__)

# test for
class RedmineGitlabOmniauthTest < ActiveSupport::TestCase
  include RedmineGitlabOmniauth

  def setup
    Setting['plugin_redmine_gitlab_omniauth']['app_id'] = nil
  end

  def test_use_middleware_when_non_empty_setting
    Setting['plugin_redmine_gitlab_omniauth']['app_id'] = 'id'
    # this cause "can't modify frozen Array" here
    # but this array is not frozen when init.rb running
    exception = assert_raises(Exception) { use_middleware }
    assert_equal("can't modify frozen Array", exception.message)
  end

  def test_use_middleware_when_empty_setting
    use_middleware
    assert_nothing_raised(Exception) { use_middleware }
  end
end
