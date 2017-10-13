require 'test_helper'

class MoviesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "nikos", email: "nstanogias@gmail.com", password: "password", password_confirmation: "password")
    @movie = Movie.create(name: "matrix",description: "great movie", user: @user)
  end

  test "reject invalid movie update" do
    sign_in_as(@user, "password")
    get edit_movie_path(@movie)
    assert_template 'movies/edit'
    patch movie_path(@movie), params: { movie: { name: " ", description: "some description" } }
    assert_template 'movies/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successfully edit a movie" do
    sign_in_as(@user, "password")
    get edit_movie_path(@movie)
    assert_template 'movies/edit'
    updated_name = "updated movie name"
    updated_description = "updated movie description"
    patch movie_path(@movie), params: { movie: { name: updated_name, description: updated_description } }
    assert_redirected_to movie_path(@movie)
    #follow_redirect!
    assert_not flash.empty?
    @movie.reload
    assert_match updated_name, @movie.name
    assert_match updated_description, @movie.description
  end

end
