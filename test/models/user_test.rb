require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "nikos", email: "nstanogias@gmail.com", password: "password", password_confirmation: "password")
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end

  test "password should be at least 5 character" do
    @user.password = @user.password_confirmation = "x" * 4
    assert_not @user.valid?
  end

  test "associated movies should be destroyed" do
    @user.save
    @user.movies.create!(name: "testing delete", description: "testing delete function")
    assert_difference 'Movie.count', -1 do
      @user.destroy
    end
  end

end
