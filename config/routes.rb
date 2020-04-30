Rails.application.routes.draw do
  resources :links

  get '/', to: 'links#index'
  get '/:short', to: 'links#root', as: 'root'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
