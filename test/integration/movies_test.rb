require 'test_helper'

class MoviesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "nikos", email: "nstanogias@gmail.com", password: "password", password_confirmation: "password")
    @movie = Movie.create(name: "movie1", description: "test", user: @user)
    @movie2 = @user.movies.build(name: "movie2", description: "test")
    @movie2.save
  end

  test "should get movies index" do
    get movies_path
    assert_response :success
  end

  test "should get movies listing" do
    get movies_path
    assert_template 'movies/index'
    assert_select "a[href=?]", movie_path(@movie), text: @movie.name
    assert_select "a[href=?]", movie_path(@movie), text: @movie.name
  end

  test "should get movies show" do
    sign_in_as(@user, "password")
    get movie_path(@movie)
    assert_template 'movies/show'
    assert_match @movie.name.capitalize, response.body
    assert_match @movie.description, response.body
    assert_match @user.username, response.body
    assert_select 'a[href=?]', edit_movie_path(@movie), text: "Edit this movie"
    assert_select 'a[href=?]', movie_path(@movie), text: "Delete this movie"
    assert_select 'a[href=?]', movies_path, text: "Return to movies listing"
  end

  test "create new valid movie" do
    sign_in_as(@user, "password")
    get new_movie_path
    assert_template 'movies/new'
    name_of_movie = "chicken saute"
    description_of_movie = "add chicken, add vegetables,cook for 20 minutes, serve delicious meal"
    assert_difference 'Movie.count', 1 do
      post movies_path, params: { movie: { name: name_of_movie,

                                                     description: description_of_movie}}
    end
    follow_redirect!
    assert_match name_of_movie.capitalize, response.body
    assert_match description_of_movie, response.body
  end

  test "reject invalid movie submissions" do
    sign_in_as(@user, "password")
    get new_movie_path
    assert_template 'movies/new'
    assert_no_difference 'Movie.count' do
      post movies_path, params: { movie: { name: " ", description: " " } }
    end
    assert_template 'movies/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
