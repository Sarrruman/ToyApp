class SessionsController < ApplicationController

    def new
    end

    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        # Log the user in and redirect to the user's show page.
        log_in(user)
        #remember user # pomocu cooky-ja
        #pita da li je checkbox==1 i odlucuje da li da sacuva korisnika
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        logger.debug "SSSSSSSSSSSSSSSSSSSSSSSesija je: #{session[:forwarding_url]} !!!!!!!!!!!!!!!!!!!!!!!"
        redirect_back_or user
      else
        flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
        render 'new'
      end
    end

    def destroy
      log_out if logged_in?
      redirect_to root_url
    end

end
