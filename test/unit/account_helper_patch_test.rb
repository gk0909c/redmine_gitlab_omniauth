require File.expand_path('../../test_helper', __FILE__)

# test for
class RedmineGitlabOmniauthTest < ActiveSupport::TestCase
  include AccountHelperPatch

  def setup
    Setting['plugin_redmine_gitlab_omniauth']['app_id'] = nil
  end

  def test_app_id_is_not_set
    refute(setting_complete?)
  end

  def test_app_id_is_set
    Setting['plugin_redmine_gitlab_omniauth']['app_id'] = 'id'
    assert(setting_complete?)
  end
end
