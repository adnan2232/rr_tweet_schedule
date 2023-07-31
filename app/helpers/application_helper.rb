module ApplicationHelper
    def get_user
        if session[:user_id]
            begin
                @user = User.find(session[:user_id])
            rescue
                session.delete(:user_id)
            end
        end
    end


end
