require 'account_controller'

# gitlab omniauth controller
class RedmineGitlabOmniauthController < ApplicationController
  unloadable

  def callback
    user = find_or_create_user(request.env['omniauth.auth']['info'])
    self.logged_user = user
    redirect_to home_path
  end

  def failure
    flash[:error] = params[:error_reason]
    redirect_to signin_path
  end

  private

  def find_or_create_user(info)
    username = info['username']
    user = User.find_or_initialize_by(login: username)

    if user.new_record?
      name = info['name']

      user.login = username
      user.mail = info['email']
      user.firstname, user.lastname = name.split(' ') unless name.nil?
      user.save
    end

    user
  end
end
