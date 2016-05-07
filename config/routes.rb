Rails.application.routes.draw do
  root to: "portfolios#index"

  resources :portfolios , :except => [:new] do
  	collection do
  		get :import_form
  		post :import
  	end
  end
end
