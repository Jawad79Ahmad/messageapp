class ChatroomController < ApplicationController

	def index
		@message = Message.new
		@user = User.all
		@msg_list = Message.all
	end
end
