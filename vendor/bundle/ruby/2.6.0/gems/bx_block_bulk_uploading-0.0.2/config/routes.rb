BxBlockBulkUploading::Engine.routes.draw do
  resources :attachments, only: %i(create destroy)
end
