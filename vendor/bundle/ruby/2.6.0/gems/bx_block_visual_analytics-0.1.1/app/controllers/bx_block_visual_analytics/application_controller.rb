# frozen_string_literal: true

# application_controller.rb
module BxBlockVisualAnalytics
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token
    skip_before_action :verify_authenticity_token
    protect_from_forgery with: :null_session

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def current_user
      @current_user ||= AccountBlock::Account.find(@token.id) if @token.present?
    end

    def not_found
      render json: { 'errors' => ['Record not found'] }, status: :not_found
    end
  end
end
