class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
   def index
    @title = "All users"
    @users = User.all
  end




  def new
  	@user = User.new
    @title = "Registrieren"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @surveys = @user.surveys

  end

  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Hallo " + @user.login + "."
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
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
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end


  
  private

    def authenticate
      deny_access unless signed_in?
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end



end
