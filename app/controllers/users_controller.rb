class UsersController < ApplicationController
  
  # Setting the rights with an extra method (only for needet actions)
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :not_logged_in,:only   => [:create, :new]
  before_filter :correct_user, :only   => [:edit, :update]
  before_filter :admin_user,   :only   => :destroy
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def show
    @user       = User.find(params[:id])
    @title      = @user.name
    @microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def following
    @title  = "Following"
    @user   = User.find(params[:id])
    @users  = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def index
    @title   = "All Users"
    @users  = User.paginate(:page => params[:page])
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render :edit
    end
  end
  
  def destroy
    @user_to_destroy = User.find(params[:id])
    if current_user == @user_to_destroy
      flash[:error] = "You can not delete your own account."
    else
      @user_to_destroy.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end
  
  private
    
    def not_logged_in
      redirect_to(root_path) if signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless (current_user != nil && current_user.admin?)
    end
end