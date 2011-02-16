class SessionsController < ApplicationController
  def new
    @title = "Einloggen"
  end

  def create
    user = User.authenticate(params[:session][:login],
    params[:session][:passwort])
    if user.nil?
      flash.now[:error] = "Sie failen mal wieder richtig. Geben sie den richtigen Namen oder das richtie Passwort ein."
      @title = "Sign in"
      render 'new'
    else
    # Sign the user in and redirect to the user's show page.
      sign_in user
      redirect_to user

    end
  end

  def destroy
    sign_out
    #redirect_to root_path
    redirect_to home_path
  end

end
