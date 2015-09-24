require 'test_helper'

class SocialControllerTest < ActionController::TestCase
  test "should get app" do
    get :app
    assert_response :success
  end

end
