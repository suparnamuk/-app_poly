# frozen_string_literal: true

module BxBlockQrCodes
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockQrCodes
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_qr_codes.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockQrCodes::Engine => base + '/qr_codes'
      end
    end
  end
end
