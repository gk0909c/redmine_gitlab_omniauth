module RedmineGitlabOmniauth
  # helper patch to account
  module AccountHelperPatch
    def setting_complete?
      !Setting['plugin_redmine_gitlab_omniauth']['app_id'].nil?
    end
  end
end

require 'account_helper'
AccountHelper.send :include, RedmineGitlabOmniauth::AccountHelperPatch
