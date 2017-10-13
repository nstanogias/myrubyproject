require 'test_helper'

class MoviesDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "nikos", email: "nstanogias@gmail.com", password: "password", password_confirmation: "password")
    @movie = Movie.create(name: "matrix",description: "great movie", user: @user)
  end

  test "successfully delete a movie" do
    sign_in_as(@user, "password")
    get movie_path(@movie)
    assert_template 'movies/show'
    assert_select 'a[href=?]', movie_path(@movie), text: "Delete this movie"
    assert_difference 'Movie.count', -1 do
      delete movie_path(@movie)
    end
    assert_redirected_to movies_path
    assert_not flash.empty?
  end
end
