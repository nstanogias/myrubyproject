class PagesController < ApplicationController

def home
  redirect_to movies_path if logged_in?
end

end
