class SessionController < ApplicationController


    def logout_user
        session.delete(:user_id)
        redirect_to root_path, notice: "Successfully Logged out"
    end
end
