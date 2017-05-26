require File.expand_path('../../test_helper', __FILE__)
require 'minitest/autorun'

# test for
class ApplicationControllerPatchTest < ActiveSupport::TestCase
  def create_mock(request_path)
    Object.send :prepend, ApplicationControllerPatch
    o = MiniTest::Mock.new
    o.expect(:require_login, nil)
    request = MiniTest::Mock.new
    request.expect(:env, 'REQUEST_PATH' => request_path)
    o.expect(:request, request)
  end

  def test_when_not_gitlab_callback
    o = create_mock('/projects')
    o.require_login
    assert o.verify
  end

  def test_when_gitlab_callback
    o = create_mock('/auth/gitlab/callback')
    o.require_login
    assert_raises(MockExpectationError) { o.verify }
  end
end
