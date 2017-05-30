require File.expand_path('../../test_helper', __FILE__)

# controller test
class RedmineGitlabOmniauthControllerTest < ActionController::TestCase
  def setup
    super

    @existing_user = User.create(login: 'testuser2', mail: 'test2@example.com',
                                 firstname: 'first2', lastname: 'family2')
  end

  test 'callback action when new user' do
    request.env['omniauth.auth'] = request_info('testuser')
    get(:callback)

    assert_redirected_to home_path
    current_user = User.current
    assert_equal(User.last, current_user)
    assert_equal('testuser', current_user.login)
    assert_equal('first', current_user.firstname)
    assert_equal('family', current_user.lastname)
    assert_equal('test@example.com', current_user.mail)
  end

  test 'callback action when existing user' do
    request.env['omniauth.auth'] = request_info('testuser2')
    get(:callback)

    assert_redirected_to home_path
    current_user = User.current
    assert_equal(@existing_user, current_user)
    assert_equal('testuser2', current_user.login)
    assert_equal('first2', current_user.firstname)
    assert_equal('family2', current_user.lastname)
    assert_equal('test2@example.com', current_user.mail)
  end

  test 'failure action' do
    get(:failure, error_type: 'error test')
    assert_redirected_to signin_path
    assert_match(/.+error\stest/, flash[:error])
  end

  private

  def request_info(username)
    {
      'info' => {
        'username' => username,
        'name' => 'first family',
        'email' => 'test@example.com'
      }
    }
  end
end
