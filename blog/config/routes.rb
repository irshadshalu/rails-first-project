Rails.application.routes.draw do
  root to: "articles#index"
  devise_for :users
  get '/', to: redirect('/articles')

  resources :articles do
    resources :comments
  end

  resources :users do
    resources :articles
  end
end
