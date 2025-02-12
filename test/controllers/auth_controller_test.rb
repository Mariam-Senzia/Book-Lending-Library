require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(name: "reader", email: "reader@gmail.com", password: "12345")
  end

  test "should create user successfully" do
    new_user_params = { user: { name: "new_reader", email: "new_reader@gmail.com", password: "12345" } }
    
    post signup_url, params: new_user_params, as: :json
    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal "User created successfully", json_response["message"]
  end

  test "should login user successfully" do
    post login_url, params: { email: @user.email, password: @user.password }, as: :json
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal "Login successful", json_response["message"]
  end

  test "should not login with invalid credentials" do
    post login_url, params: { email: @user.email, password: "wrongpassword" }, as: :json
    assert_response :unauthorized
    json_response = JSON.parse(response.body)
    assert_equal "Invalid email or password", json_response["error"]
  end
end