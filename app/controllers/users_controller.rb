class UsersController < ApplicationController

  layout 'application'

  before_filter :signed_in_user, except: [:new, :create, :edit_attempt]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:index, :list, :destroy]

  def index
  	list
  	render('list')
  end

  def list
    @users = User.sorted
    # was:
  	# @admin_users = AdminUser.sorted
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = 'Account successfully created.'
      redirect_to(:controller => 'topics', :action => 'list')
    else
      render 'new'
    end
  end

  def edit
    if current_user.id == !nil
      @user = User.find_by_id(params[:id])
    elsif current_user.id == nil
      @user = User.find_by_email(params[:session][:email].downcase)
    end
  end

  def edit_attempt
    # if session[:return_to] == users_edit_attempt_path
    #   user_id = User.find_by_email(params[:session][:email].downcase).id
    #   redirect_to edit_user_path(:id => user_id)
    # end
    redirect_to new_session_path
    flash[:notice] = "Please sign in or create an account to view or update your user information."
  end

  def update
  	@user = User.find(params[:id])
    # note: here hartl has (in listing 9.15 - not sure about final version - not in my final sample_app)
    # if @user.update_attributes(user_params)
    if @user.update_attributes(params[:user])
  	    flash[:success] = 'User updated.'
        # the redirect used to also include ":id => @user.id" (no quotes)
        redirect_to(:action => 'show')
	  else 
  	    render('edit')
	  end
  end

  def delete
  	@user = User.find(params[:id])
  end

  def destroy
  	user = User.find(params[:id])
    user.destroy
    flash[:success] = "User deleted."
    redirect_to(:action => 'index')
  end

  # this action is for when a user tries to update his profile information
  # from the "my wonk settings" link on the homepage
  # but without being signed in
  # def user_edit_attempt_when_not_signed_in
  #   store_location
  #   redirect_to new_session_path
  #   flash.now[:notice] = "Please sign in to edit your profile information."
  # end

  # these are hartl methods:
  private

    # note: this is from listing 9.15 of hartl but i don't have it
    # in my final version of sample_app
    # def user_params
    #   params.require(:user).permit(:name, :email, :password,
    #                                :password_confirmation)
    # end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    # note: this is where hartl has his admin_user method definition
    # i put mine in sessions_helper so i could access it with controllers other than users_controller

    def new_user
      redirect_to(root_path) if signed_in?
    end

end
