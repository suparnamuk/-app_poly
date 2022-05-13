# frozen_string_literal: true

require 'builder_base/generators/install/base'

module BxBlockPaymentAdmin
  module Block
    class InstallGenerator < BuilderBase::Generators::Install::Base
      set_file_directory __dir__
    end
  end
end
