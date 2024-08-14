class SessionsController < ApplicationController
    def new
        if session[:user_id].present? 
            redirect_to user_path(session[:user_id])
        end
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to chats_path, notice: "Welcome Back #{user.name}!"
        else
            flash.now[:alert] = "Invalid email/password combination!"
            render :new,  status: :unprocessable_entity
        end

    end

    def destroy
        session[:user_id] = nil 
        redirect_to signin_path, notice: "Signed Out Successfully"
    end


    private
    
end