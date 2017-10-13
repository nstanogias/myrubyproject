require 'test_helper'

class UsersListingTest < ActionDispatch::IntegrationTest
  def setup
      @user = User.create!(username: "nikos", email: "nikos@example.com",
                      password: "password", password_confirmation: "password")
      @user2 = User.create!(username: "john", email: "john@example.com",
                      password: "password", password_confirmation: "password")
      @admin_user = User.create!(username: "john1", email: "john1@example.com",
                        password: "password", password_confirmation: "password", admin: true)
    end

    test "should get users listing" do
      sign_in_as(@user2, "password")
      get users_path
      assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user), text: @user.username.capitalize
    assert_select "a[href=?]", user_path(@user2), text: @user2.username.capitalize
    end

    test "should delete user" do
      sign_in_as(@admin_user, "password")
      get users_path
      assert_template 'users/index'
      assert_difference 'User.count', -1 do
        delete user_path(@user)
      end
      assert_redirected_to users_path
      assert_not flash.empty?
    end

    test "accept edit attempt by admin user" do
      sign_in_as(@admin_user, "password")
      get edit_user_path(@user)
      assert_template 'users/edit'
      patch user_path(@user), params: { user: { username: "nikos3",
                                    email: "nikos3@example.com" } }
      assert_redirected_to @user
      assert_not flash.empty?
      @user.reload
      assert_match "nikos3", @user.username
      assert_match "nikos3@example.com", @user.email
    end

    test "redirect edit attempt by another non-admin user" do
      sign_in_as(@user2, "password")
      updated_name = "joe"
      updated_email = "joe@example.com"
      patch user_path(@user), params: { user: { username: updated_name,
                                    email: updated_email } }
      assert_redirected_to users_path
      assert_not flash.empty?
      @user.reload
      assert_match "nikos", @user.username
      assert_match "nikos@example.com", @user.email
    end
end
