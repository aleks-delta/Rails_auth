class SessionsController < ApplicationController
  def new
  	flash.now[:danger] = "New"
  end
  def create
  	flash.now[:danger] = "Creating"
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		logger.debug("Authentication successful")
  		
  		session[:user_id] = user.id
  		flash[:success] = "Welcome to rails"
  		redirect_to root_path
  	else
  		logger.debug("Authentication failed")
  	  if (!user)
        flash.now[:danger] = "No user with email "+params[:email]+" in the database"
      else 
  		  flash.now[:danger] = "Incorrect credentials for user " + user.name
      end
  		render 'new'
  	end
  end

  def destroy
  	logger.debug("destroying")
  	session[:user_id] = nil
  	flash[:success] = "Good bye"
  	redirect_to root_path
  end
end
