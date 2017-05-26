module RedmineGitlabOmniauth
  # patch application_controller
  module ApplicationControllerPatch
    def require_login
      return if request.env['REQUEST_PATH'] == '/auth/gitlab/callback'
      super
    end
  end
end

require 'application_controller'
ApplicationController.send :prepend,
                           RedmineGitlabOmniauth::ApplicationControllerPatch
