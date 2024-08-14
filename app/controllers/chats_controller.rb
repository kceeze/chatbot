class ChatsController < ApplicationController
	before_action :require_signin
    def index
        @chats = Chat.all 
    end

    def new
        @chat = find_chat 
				@chat_messages = ChatMessage.where(chat: @chat).order("id desc").limit(10).reverse
    end

    def show 

    end

    def create

    end

    private
    def find_chat
    	chat = Chat.find_by(user: current_user)
			if chat.nil?
				chat = Chat.new(user: current_user)
				chat.save
				chat
			else
				chat 
			end
    end

end
