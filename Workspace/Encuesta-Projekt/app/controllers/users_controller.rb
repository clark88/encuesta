class UsersController < ApplicationController
  def index
    flash[:notice] = "You did it"
  end

  def new
  	@user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name

  end

  def create
    user = User.new()
    user.name = params[:user][:name]
    user.vorname = params[:user][:vorname]
    user.login = params[:user][:login]
    user.passwort = params[:user][:passwort]
    user.email = params[:user][:email]
    user.save
    redirect_to(users_path)
  end

  def edit
    #@user =User.find(params[:id])
    @user = User.find_by_login(params[:login])

    if session [:user_id] != @user.user_id
      flash[:notice] = "Sorry du bist nicht der richtige User"
      redirect_to(users_path)
    end

    if session [:user_id] == @user.user_id
      @user.name = params[:user][:name]
      @user.vorname = params[:user][:vorname]
      @user.login = params[:user][:login]
      @user.passwort = params[:user][:passwort]
      @user.email = params[:user][:email]
      @user.save
      redirect_to(users_path)
    end

  end

  def delete
    @user =User.find(params[:id])

    if session [:user_id] != @user.user_id
      flash[:notice] = "Sorry du bist nicht der richtige User"
      redirect_to(users_path)
    end

    if session [:user_id] == @user.user_id
    @user.delete
    end
  end

end
