Champfrogs::Application.routes.draw do
  post '/answers' => 'home#save_answer'
  root :to => 'home#index'
end
