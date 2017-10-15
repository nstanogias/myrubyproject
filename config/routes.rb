Rails.application.routes.draw do
	root "pages#home"
	get 'pages/home', to: 'pages#home'
	get 'signup', to: 'users#new'
	resources :users, except: [:new]
	resources :movies do
		resources :comments, only: [:create]
	end

	get '/login', to: 'sessions#new'
	post '/login', to: "sessions#create"
	delete '/logout', to: "sessions#destroy"

	resources :genres, except: [:destroy]

	mount ActionCable.server => '/cable'

	get '/chat', to: 'chatrooms#show'
	resources :messages, only: [:create]
end
