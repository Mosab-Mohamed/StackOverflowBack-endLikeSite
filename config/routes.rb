Rails.application.routes.draw do
  devise_for :user, only: []

  namespace :api, defaults: { format: :json } do
  	namespace :v1 do

	    resource :login, only: [:create], controller: :sessions
	    resource :logout, only: [:destroy], controller: :sessions
	    resources :users, only: [:create , :show , :update , :destroy]
	    resources :questions, only: [:create , :index , :update , :destroy]
	    resources :answers, only: [:create , :update , :destroy]
	    resources :answer_edits, only: [:create , :update , :destroy]
	    resources :comments, only: [:create , :update , :destroy , :show]
	    resources :question_edits, only: [:create , :update , :destroy]
	    resources :favourites, only: [:create  , :destroy]
	    resources :votes, only: [:create ]
	    resources :tag_questions, only: [:create , :index]
	    resources :tags, only: [:create]

	    delete 'votes/destroyall' => 'votes#destroyall'
	    get 'questions/:id' => 'questions#show_question'
	    get 'search/questions' => 'questions#search'
	    get 'search/users' => 'users#search'
	    put 'questions/:id/resolve' => 'questions#set_resolved'
      put 'answers/verify/:id' => 'answers#verify'

	end
  end
end