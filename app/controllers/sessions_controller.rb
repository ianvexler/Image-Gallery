class SessionsController < ApplicationController
    #Controller to deal with the sessions

    def new
        if session[:logged_in]
            redirect_to error_path
        end
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
            if !params[:email].present?
                flash[:alert] << "Email can't be empty"
            end
    
            if !params[:password].present?
                flash[:alert] << "Password can't be empty"
            end
            
            if params[:email].present? && params[:password].present?
                flash[:alert] << "Invalid inputs"
            end

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
