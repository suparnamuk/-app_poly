module AccountBlock
  class AccountSerializer < BuilderBase::BaseSerializer
    attributes *[
      :activated,
      :country_code,
      :email,
      :first_name,
      :full_phone_number,
      :last_name,
      :phone_number,
      :user_type,
      :type,
      :created_at,
      :updated_at,
      :device_id,
      :unique_auth_id
    ]

    attribute :country_code do |object|
      country_code_for object
    end
    attribute :phone_number do |object|
      phone_number_for object
    end
    attribute :date_of_birth do |object|
      object.date_of_birth  if object.user_type == "customer"
    end
    attribute :address do |object|
      object.address  if object.user_type == "customer"
    end
      attribute :exsisting_disease do |object|
      object.exsisting_disease  if object.user_type == "customer"
    end
      attribute :pincode do |object|
      object.pincode  if object.user_type == "customer"
    end
    attribute :bank_name do |object|
      object.bank_name  if object.user_type == "merchant"
    end
    attribute :account_number do |object|
      object.account_number  if object.user_type == "merchant"
    end
    attribute :ifsc_code do |object|
      object.ifsc_code  if object.user_type == "merchant"
    end

    attribute :pan_card do |object, params|
      if object.user_type == "merchant"
        host = params[:host] || ''
        if object.pan_card.present?
           host + Rails.application.routes.url_helpers.rails_blob_url(object.pan_card, only_path: true)
        end
      end
    end

    attribute :cancelled_cheque do |object, params|
      if object.user_type == "merchant"
        host = params[:host] || ''
        if object.cancelled_cheque.present?
           host + Rails.application.routes.url_helpers.rails_blob_url(object.cancelled_cheque, only_path: true)
        end
      end
    end
    
    attribute :aadhar_card do |object, params|
      if object.user_type == "merchant"
        host = params[:host] || ''
        if object.aadhar_card.present?
           host + Rails.application.routes.url_helpers.rails_blob_url(object.aadhar_card, only_path: true)
        end
      end
    end
    
    class << self
      private

      def country_code_for(object)
        return nil unless Phonelib.valid?(object.full_phone_number)
        Phonelib.parse(object.full_phone_number).country_code
      end

      def phone_number_for(object)
        return nil unless Phonelib.valid?(object.full_phone_number)
        Phonelib.parse(object.full_phone_number).raw_national
      end
    end
  end
end
