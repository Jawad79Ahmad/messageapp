class UsersController < ApplicationController
	before_action :set_id, only: [ :show, :edit, :update ]
	before_action :find_user, only: [ :show, :destroy ]
	before_action :require_user, only: [ :edit, :update ]

	def new
		if logged_in?
			flash[:alert] = "Someone is already logged in"
			redirect_to root_path
		else
			@user = User.new
		end
	end

	def create
		if logged_in?
			flash[:alert] = "Someone is already logged in"
			redirect_to root_path
		else
			@user = User.new(set_params)
			if @user.save
				session[:user_id] = @user.id
				flash[:notice] = "User Signed up successfully."
				redirect_to root_path
			else
				render 'new'
			end
		end
	end

	def show
	end

	def edit
	end
	def update
			if @user.update(set_params)
				session[:user_id] = @user.id
				flash[:notice] = "User is successfully updated."
				redirect_to root_path
			else
				render 'new'
			end
		end
	end

	private
	def set_id
		@user = User.find(params[:id])
	end
	def set_params
		params.require(:user).permit(:username, :email, :password)
	end
	def require_user
		if !(logged_in?)
			flash[:alert] = "Login to perform that action."
			redirect_to login_path
		else if (current_user != @user)
			flash[:alert] = "Only user who logged-in can perform that action."
			redirect_to login_path
		end
	end
end
