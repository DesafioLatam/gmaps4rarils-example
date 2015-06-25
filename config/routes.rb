Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users do
  	collection do
  		get 'address' => "users#address", as: "address"
  	end
  end
end
