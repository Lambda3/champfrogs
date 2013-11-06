Champfrogs::Application.routes.draw do
  post '/answers' => 'home#save_answer'
  get '/company_motivators' => 'home#company_motivators'
  root :to => 'home#index'
end
