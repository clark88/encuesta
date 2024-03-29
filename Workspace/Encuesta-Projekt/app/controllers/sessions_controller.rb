class SessionsController < ApplicationController
  def new
    @title = "Einloggen"
  end
	#erstellt eine neue Session über den User
  def create
    user = User.authenticate(params[:session][:email],params[:session][:passwort])
    #p user
    if user.nil?
      flash.now[:error] = "Der Name/E-Mail oder das Passwort sind falsch. Bitte geben Sie den richtigen Namen oder das richtie Passwort ein."
      @title = "Sign in"
      render 'new'
    else
    # Sign the user in and redirect to the user's show page.
      sign_in user
      redirect_to home_path

    end
  end
	#logt aus und geht zurück zur Home
  def destroy
    sign_out
    #redirect_to root_path
    redirect_to home_path
  end

end
