require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get learn_turbohearts" do
    get :learn_turbohearts
    assert_response :success
  end

end
