# frozen_string_literal: true

module BxBlockCustomForm
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockCustomForm
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_custom_form.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockCustomForm::Engine => base + '/custom_form'
      end
    end
  end
end
