class UserProfileController < ApplicationController

    before_action :require_user_logged_in!

    def index
    end

    def update_password
       
        if !(Current.user && Current.user.authenticate(params[:user][:current_password]))
            return redirect_to :user_profile, alert:'current password didn\'t match old password' 
        elsif Current.user.update(
            password:params[:user][:password],
            password_confirmation:params[:user][:password_confirmation]
        )
            redirect_to :user_profile, notice: "Password changed successfully"
        else
            render :index
        end 
    end


end
