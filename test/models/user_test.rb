require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "test", email: "test@gmail.com", password: "123")
  end

  test "should be invalid without a name" do
    @user.name = nil
    assert_not @user.valid?
    assert_includes @user.errors[:name], "can't be blank"
  end

  test "should be invalid without an email" do
    @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "should have a unique email" do
    user1 = User.create(name: "test", email: "test@gmail.com", password: "123")
    user2 = User.new(name: "test", email: "test@gmail.com", password: "123")

    assert_not user2.valid?
    assert_includes user2.errors[:email], "has already been taken"
  end

  test "should be invalid with an incorrect email format" do
    invalid_emails = ["plainaddress", "missing@domain", "user@.com", "user@domain,com"]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} should be invalid"
      assert_includes @user.errors[:email], "is invalid"
    end
  end

  test "should be invalid without a password" do
    @user.password = nil
    assert_not @user.valid?
    assert_includes @user.errors[:password], "can't be blank"
  end

  test "should respond to books" do
    assert_respond_to @user, :books
  end

  test "should respond to borrowings" do
    assert_respond_to @user, :borrowings
  end
end
