class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #build methods to check if user is logged in before allowing them to do certain actions
  
  helper_method :current_user, :logged_in? #let rails know this is a helper method, made available to all views in app
  
  def current_user
    #@current_user || = checks to see if the user information has already been returned so the program doesn't continually check the database during a session.
    #if the user object has already been returned, the rest of the line is not executed.  If there is no user object, then it goes to the database and pulls it.
    @current_user || User.find(session[:user_id]) if session[:user_id] #return the "user" for whatever user-ID is logged in, so we can access the entire user object, not just id
  end
  
  def logged_in?
    !!current_user #convert current_user to boolian to check if it's true or false (logged in or not)
  end
  
  def require_user #check if the user is logged in and redirect them to the home page if they are not
  #used to test when a user tries to do something they must be logged in to do
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
    
  end
  
end
