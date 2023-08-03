class SessionController < ApplicationController


    def destroy

        session.delete(:user_id)
        redirect_to root_path, notice: "Successfully Logged out"
    end

    def new
    end
    
    def create
        @user = User.find_by(:email=>params[:email])

        if @user
            if @user.authenticate(params[:password])
                reset_session
                session[:user_id] = @user.id
                flash[:notice] = "You're Successfully Logged in"
                return redirect_to root_path
            end
        end
        
        flash[:alert] = "Incorrect password or email"
        render :new, status: :unprocessable_entity

    end
end
