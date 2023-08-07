class OmniauthCallbacksController < ApplicationController

    def twitter
        
        begin
            
            Current.user.twitter_accounts.create!(
                name: auth.info.name,
                username: auth.info.nickname,
                image: auth.info.image,
                token: auth.credentials.token,
                secret: auth.credentials.secret,
            )

            redirect_to controller: :twitter_accounts, action: :index, notice: "Successfully connected your account"

        rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error e
            redirect_to controller: :twitter_accounts, action: :index, alert: "Twitter account is already linked"
        end
    end

    def auth
        request.env['omniauth.auth']
    end
end