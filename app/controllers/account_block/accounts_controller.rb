module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token, only: :search

    def create
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account'

          @sms =  SmsAccount.new(jsonapi_deserialize(params))
          @sms.activated = "true"
          unless @sms.save
            return render json: {errors: (@sms.errors.full_messages)},
            status: :unprocessable_entity
          end
          @sms_otp = SmsOtp.new(full_phone_number: @sms.full_phone_number)
          @sms_otp.activated = "true"
          if @sms_otp.save(validate: false)
            render json: SmsOtpSerializer.new(@sms_otp, account: AccountBlock::SmsAccountSerializer.new(@sms),meta: {
            token: BuilderJsonWebToken.encode(@sms_otp.id),
            }).serializable_hash, status: :created
          else
            render json: {errors: format_activerecord_errors(@sms_otp.errors)},
            status: :unprocessable_entity
          end
        
      when 'email_account'
        account_params = jsonapi_deserialize(params)

        query_email = account_params['email'].downcase
        account = EmailAccount.where('LOWER(email) = ?', query_email).first

        validator = EmailValidation.new(account_params['email'])

        return render json: {errors: [
          {account: 'Email invalid'},
        ]}, status: :unprocessable_entity if account || !validator.valid?

        @account = EmailAccount.new(jsonapi_deserialize(params))
        @account.platform = request.headers['platform'].downcase if request.headers.include?('platform')

        if @account.save
          EmailAccount.create_stripe_customers(@account)
          EmailValidationMailer
            .with(account: @account, host: request.base_url)
            .activation_email.deliver
          render json: EmailAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
          }).serializable_hash, status: :created
        else
          render json: {errors: format_activerecord_errors(@account.errors)},
            status: :unprocessable_entity
        end

      when 'social_account'
        @account = SocialAccount.new(jsonapi_deserialize(params))
        @account.password = @account.email
        if @account.save
          render json: SocialAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
          }).serializable_hash, status: :created
        else
          render json: {errors: format_activerecord_errors(@account.errors)},
            status: :unprocessable_entity
        end

      else
        render json: {errors: [
          {account: 'Invalid Account Type'},
        ]}, status: :unprocessable_entity
      end
    end

    def search
      @accounts = Account.where(activated: true)
                    .where('first_name ILIKE :search OR '\
                           'last_name ILIKE :search OR '\
                           'email ILIKE :search', search: "%#{search_params[:query]}%")
      if @accounts.present?
        render json: AccountSerializer.new(@accounts, meta: {message: 'List of users.'
        }).serializable_hash, status: :ok
      else
        render json: {errors: [{message: 'Not found any user.'}]}, status: :ok
      end
    end

    def update
      #byebug
      @account = AccountBlock::Account.find(params[:id]) 
      if  create_params["user_type"].blank?
            return render json: {errors: [
              {account: 'user type should not be blank'},
            ]}, status: :unprocessable_entity
      end

      if create_params["user_type"] == 'merchant'
        if create_params["first_name"].blank?
            return render json: {errors: [
              {account: 'First Name can not be blanked'},
            ]}, status: :unprocessable_entity
        end

          if create_params["last_name"].blank?
            return render json: {errors: [
              {account: 'last Name can not be blanked'},
            ]}, status: :unprocessable_entity
          end

          if create_params["email"].blank?
            return render json: {errors: [
              {account: 'email can not be blanked'},
            ]}, status: :unprocessable_entity
          end

          if create_params["phone_number"].blank?
            return render json: {errors: [
              {account: 'Phone Number can not be blanked'},
            ]}, status: :unprocessable_entity
          end
          
          if create_params["bank_name"].blank?
            return render json: {errors: [
              {account: 'Bank Name should not be blank'},
            ]}, status: :unprocessable_entity
          end

          if  create_params["account_number"].blank?
            return render json: {errors: [
              {account: 'bank account number should not be blank'},
            ]}, status: :unprocessable_entity
          end

          if  create_params["ifsc_code"].blank?
            return render json: {errors: [
              {account: 'Ifsc code can not be blanked'},
            ]}, status: :unprocessable_entity
          end

          if create_params["pan_card"].blank?
            return render json: {errors: [
              {account: 'pan_card should not be blank'},
            ]}, status: :unprocessable_entity
          end

          if create_params["aadhar_card"].blank?
            return render json: {errors: [
              {account: 'aadhar_card should not be blank'},
            ]}, status: :unprocessable_entity
          end

          if create_params["cancelled_cheque"].blank?
            return render json: {errors: [
              {account: 'cancelled_cheque should not be blank'},
            ]}, status: :unprocessable_entity
          end
       elsif create_params["user_type"] == 'customer'
           if create_params["first_name"].blank?
            return render json: {errors: [
              {account: 'First Name can not be blanked'},
            ]}, status: :unprocessable_entity
          end

          if create_params["last_name"].blank?
            return render json: {errors: [
              {account: 'last Name can not be blanked'},
            ]}, status: :unprocessable_entity
          end

          if create_params["date_of_birth"].blank?
            return render json: {errors: [
              {account: 'Choose Your Date of Birth'},
            ]}, status: :unprocessable_entity
          end

          if create_params["phone_number"].blank?
            return render json: {errors: [
              {account: 'Phone Number can not be blanked'},
            ]}, status: :unprocessable_entity
          end
        
          if  create_params["pincode"].blank?
            return render json: {errors: [
              {account: 'pin code can not be blanked'},
            ]}, status: :unprocessable_entity
          end
          
          if  create_params["occupation"].blank?
            return render json: {errors: [
              {account: 'occupation  can not be blanked'},
            ]}, status: :unprocessable_entity
          end
         
          if  create_params["exsisting_disease"].blank?
            return render json: {errors: [
              {account: 'exsisting disease can not be blanked'},
            ]}, status: :unprocessable_entity
          end

          if  create_params["address"].blank?
            return render json: {errors: [
              {account: 'address can not be blanked'},
            ]}, status: :unprocessable_entity
          end

          if create_params["email"].blank?
            return render json: {errors: [
              {account: 'email can not be blanked'},
            ]}, status: :unprocessable_entity
          end

       end
        if @account.update(create_params)
                      render json:AccountBlock::AccountSerializer.new( @account, meta: {message: 'account updated.'
          }).serializable_hash, status: :ok
        else
          render json: {errors: [{message: 'Account not updated.'}]}, status: :ok
      end
    end

    private

    def encode(id)
      BuilderJsonWebToken.encode id
    end

    def create_params
      params.require(:data).permit(*[:first_name, :last_name, :email, :phone_number, :user_type, :avtars, :pan_card, :cancelled_cheque, :aadhar_card, :bank_name, :account_number, :ifsc_code, :date_of_birth, :occupation, :exsisting_disease, :address, :pincode])
    end
    # def search_params
    #   params.permit(:query)
    # end
  end
end


