BxBlockQrCodes::Engine.routes.draw do
  resources :qr_codes, only: %i[create show]
end
