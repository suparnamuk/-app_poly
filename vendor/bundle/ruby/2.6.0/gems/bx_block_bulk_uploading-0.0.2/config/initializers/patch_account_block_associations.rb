Rails.application.reloader.to_prepare do
  AccountBlock::Account.include(
    BxBlockBulkUploading::PatchAccountBlockAssociations
  )
end
