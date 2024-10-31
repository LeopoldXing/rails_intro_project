Rails.application.routes.draw do
  get "pokemon/：id", to: "pokemon#show", as: :pokemon
  get "items/index"
  get "items/:id", to: "items#show", as: :item
  get "moves/index"
  get "moves/:id", to: "moves#show", as: :move
  get "abilities/index"
  get "abilities/:id", to: "abilities#show", as: :ability
  root "home#index"
  get "/about", to: "static_pages#about"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
