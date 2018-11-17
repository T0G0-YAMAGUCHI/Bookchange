Rails.application.routes.draw do
  root to: "books#index"
  
  get "signup" , to: "users#new"
  resources :users , only:[:show , :new , :create]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get "purchased/:id" , to: "users#purchased_books" , as: "purchased_books"
  get "wants/:id"  , to: "users#want_books"   , as: "want_books"
  
  resources :books , only:[:index,:show,:new,:create]
  post "books/:id", to: "books#book_sets", as: 'book_sets'
  delete "books/:id", to: "books#book_removes", as: 'book_removes'
  resources :orders , only:[:create , :destroy]
  resources :messages , only:[:create , :destroy]
end
