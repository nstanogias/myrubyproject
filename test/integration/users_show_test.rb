require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "nikos", email: "nstanogias@gmail.com",
                          password: "password", password_confirmation: "password")
    @movie = Movie.create(name: "James Bond", description: "great movie", user: @user)
    @movie2 = @user.movies.build(name: "matrix", description: "nice")
    @movie2.save
  end

  test "should get users show" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", movie_path(@movie), text: @movie.name
    assert_select "a[href=?]", movie_path(@movie2), text: @movie2.name
    assert_match @movie.description, response.body
    assert_match @movie2.description, response.body
    assert_match @user.username, response.body
  end
end
