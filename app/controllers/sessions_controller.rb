class SessionsController < ApplicationController
   
   def new
       
   end
   
   def create
       #find the user by the email address
       user = User.find_by(email: params[:session][:email].downcase)
       #verify user email exists and authenticate
       if user && user.authenticate(params[:session][:password])
          session[:user_id] = user.id #save user id in session hash, backed by browser's cookie
          flash[:success]= "You have successfully logged in"
          #send logged in user to their show page
          redirect_to user_path(user)
       else
          #Reload the login page and give an error message if login fails
          flash.now[:danger] = "There was something wrong with your login information"
          render 'new'
       end
   end
   
   def destroy
       session[:user_id] = nil
       flash[:success] = "You have successfully logged out"
       redirect_to root_path
   end
   
end