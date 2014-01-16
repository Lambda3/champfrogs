Champfrogs::Application.routes.draw do
  post '/answers' => 'home#save_answer'
  get '/company_motivators' => 'home#company_motivators'
  get '/like_me' => 'home#like_me'
  get '/biggest_matches' => 'home#biggest_matches'
  root :to => 'home#index'
end
