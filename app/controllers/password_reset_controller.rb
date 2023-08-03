class PasswordResetController < ApplicationController

    def new
    end

    def create

        user = User.find_by(email:params[:email])

        if user.present?
            PasswordMailer.with(user: user).reset.deliver_now
        end

        redirect_to root_path,notice: "Email for resetting password has been sent to #{params[:email]}"
    end

    def edit 
        @user = User.find_signed!(params[:token],purpose: "password_reset")
        rescue ActiveSupport::MessageVerifier::InvalidSignature
            redirect_to signin_path, alert: "Your token has expired, please try again."
    end

    def update
        @user = User.find_signed!(params[:token],purpose:"password_reset")
        if @user.update(password_params)
            return redirect_to signin_path,notice:"Your password has been succesfully updated, Please signin"
        end
        return render :edit
    end


    private
    def password_params
        params.require(:user).permit(:password,:password_confirmation)
    end
end
