require 'spec_helper'

describe UsersController do
  render_views

  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => "Sign Up")
    end
	
	it "should have a name field" do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end
	
	it "should have an email field" do
	  get :new
	  response.should have_selector("input[name='user[email]'][type='text']")
	end
	
	it "should have a password field" do
	  get :new
	  response.should have_selector("input[name='user[password]'][type='password']")
	end
	
	it "should have a password confirmation field" do
		get :new
		response.should have_selector("input[name='user[password_confirmation]'][type='password']")
	end
  end
  
	
  describe "POST 'create'" do
	  
	  describe "failure" do
		 
		  before(:each) do
			  @attr = { :name => "", :email => "",
						:password => "", :password_confirmation => "" }
		 end
		 
		 it "should have the right title" do
			post :create, :user => @attr 
			response.should have_selector('title', :content => "Sign Up")
		 end
		 
		 it "should render the 'new' page" do 
			 post :create, :user => @attr 
			response.should render_template('new')
		 end
		 
		 it "should not create a user" do
			 lambda do
				 post :create, :user => @attr
			 end.should_not change(User, :count)
		 end	 
	  end
  
	  describe "success" do
		  
		  before(:each) do
			  @attr = { :name => "New User", :email => "user@example.com", 
			            :password => "bullwinkle", :password_confirmation => "bullwinkle" }
		  end
		  
		  it "should create a user" do
			  lambda do
				 post :create, :user => @attr
			end.should change(User, :count).by(1)
		  end
		  
		  it "should redirect to the user show page" do
			 post :create, :user => @attr
			 response.should redirect_to(user_path(assigns(:user)))
		  end
		  
		  it "should have a welcome message" do
			 post :create, :user => @attr
			 flash[:success].should =~ /welcome to the sample app/i 
		  end
		  
		  it "should sing in the user" do
			  post :create, :user => @attr
			  controller.should be_signed_in
		  end
	  end
	end
	
	describe "GET 'edit'" do
		
		before(:each) do
			@user = Factory(:user)
			test_sign_in(@user)
		end
		
		it "should be successful" do
			get :edit, :id => @user
			response.should be_success
		end
		
		it "should have the right title" do
			get :edit, :id => @user
			response.should have_selector('title', :content => "Edit User")
		end
		
		it "should have a link to change the gravatar" do
			get :edit, :id => @user
			response.should have_selector('a', :href => "http://gravatar.com/emails",
												:content => "change")
		end
	end
	
	describe "PUT 'update'" do
	  
		before(:each) do
			@user = Factory(:user)
			test_sign_in(@user)
		end
	  
		describe "failure" do
		 
			before(:each) do
				@attr = { 	:name => "", :email => "",
							:password => "", :password_confirmation => "" }
			end
		 
			it "should render the edit page" do
				put :update, :id => @user, :user => @attr
				response.should render_template('edit')
			end
			
			it "should have the right title" do
				put :update, :id => @user, :user => @attr
				response.should have_selector('title', :content => "Edit User")
			end
		end
		
		describe "success" do
		  
			before(:each) do
			  @attr = { :name => "New Name", :email => "user2@example.com", 
			            :password => "rocky666", :password_confirmation => "rocky666" }
			end
			
			it "should change the user's attributes" do
				put :update, :id => @user, :user => @attr
				user = assigns(:user)
				@user.reload
				@user.name.should == user.name
				@user.email.should == user.email
				@user.encrypted_password.should == user.encrypted_password
			end
			
			it "should have a flash message" do
				put :update, :id => @user, :user => @attr
				flash[:success].should =~ /updated/i
			end
		end
	
	end
end
