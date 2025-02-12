require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Test User", email: "test@gmail.com", password: "123")
  end

  test "should get show if authenticated" do
    post login_path, params: { email: @user.email, password: "123" }
    get user_path(@user)
    assert_response :success
  end

  test "should redirect to login if not authenticated" do
    get user_path(@user)
    assert_redirected_to login_path
  end
end
