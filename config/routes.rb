Rails.application.routes.draw do
  get 'static_pages/home'
  root 'static_pages#home'
  resources :tags
  resources :items
  get 'items/:id/confirm_delete', to: 'items#confirm_delete', as: 'confirm_delete_item'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
