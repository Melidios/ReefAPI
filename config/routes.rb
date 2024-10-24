Rails.application.routes.draw do
  resources :stores do
    member do
      get 'total_items'
    end
    resources :items, only: [:index]
  end

  resources :items do
    resources :ingredients
  end
end
