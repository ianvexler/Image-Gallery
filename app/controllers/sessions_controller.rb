class SessionsController < ApplicationController
    class SessionsController < ApplicationController
        def new
        end
    
        def create
            flash[:alert] = []
    
            user = User.find_by(email: params[:email])
            if user.present? && user.authenticate(params[:password])
                session[:user_id] = user.id
                session[:user_email] = user.email
                session[:logged_in] = true
    
                redirect_to root_path
            else
                flash[:alert] << "Invalid inputs"
                redirect_to login_path
            end
        end
    
        def delete
            session[:user_id] = nil
            session[:user_email] = nil
            session[:logged_in] = nil
    
            redirect_to root_path
        end
    end
    
    
end
