require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
   @user = User.create!(username: "nikos", email: "nikos@gmail.com",
                          password: "password", password_confirmation: "password")
  end

  test "reject an invalid edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: " ", email: "mashrur@example.com" } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid signup" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "mashrur1",
                                email: "mashrur1@example.com" } }
    assert_redirected_to user_path(@user)
    assert_not flash.empty?
    @user.reload
    assert_match "mashrur1", @user.username
    assert_match "mashrur1@example.com", @user.email
  end

end
