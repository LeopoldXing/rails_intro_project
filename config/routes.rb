Rails.application.routes.draw do
  get "pokemon/show"
  get "items/index"
  get "items/show"
  get "moves/index"
  get "moves/show"
  get "abilities/index"
  get "abilities/show"
  root "home#index"
  get "/about", to: "static_pages#about"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
