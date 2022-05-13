Rails.application.routes.draw do
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 

    namespace :bx_block_poly do
        post 'poly_url', to:'poly#poly_url'
     end

end
