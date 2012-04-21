class UsersController < ApplicationController
  def new
	  @user  = User.new
	  @title = "Sign Up"
  end
  
  def show
    @user = User.find(params[:id])
	@title = @user.name
  end
  
  def create 
   @user  = User.new(params[:user])
   if @user.save
	   sign_in @user
	   #redirect_to @user
	   redirect_to @user, :flash => { :success => "Welcome to the Sample App" } #this is just another way to write the above 2 lines
   else	   
	@title = "Sign Up"
	@user.password = nil #clears out the password field after submit fails and new form is rendered
	@user.password_confirmation = nil #ditto above
	render 'new'
	end
  end
end
