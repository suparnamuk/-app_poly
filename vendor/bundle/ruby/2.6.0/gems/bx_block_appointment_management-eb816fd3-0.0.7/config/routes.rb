BxBlockAppointmentManagement::Engine.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Api)
  resources :availabilities, only: [:index, :create] do
    delete :delete_all, on: :collection
  end
end
