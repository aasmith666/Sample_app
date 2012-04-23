class UsersController < ApplicationController
  
	before_filter :authenticate, :only => [:index, :edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	
	def index
	  @users = User.paginate(:page => params[:page])
	  @title = "All Users"
	end
	
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
  
	def edit
		@user = User.find(params[:id])
		@title = "Edit User"
	end
  
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			redirect_to @user, :flash => { :success => "Profile updated" }
		else
			@title = "Edit User"
			render 'edit'
		end	
	end
  
	private
	def authenticate
	  #flash[:notice] = "Please sign in to access this page"
	  deny_access unless signed_in?
	end 
	
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)	
	end
end
