class ChatMessagesController < ApplicationController
  def create
    begin 
      @chat = Chat.find_by(user: current_user)
      @chat_message = ChatMessage.new(chat_message_params)
      if @chat_message.save  
        CreateChatMessageJob.perform_later( @chat_message)  
        render turbo_stream: turbo_stream.append(
           "chat_messages_#{@chat.id}", 
           partial: "chat_messages/message",
           locals: {chat_message: @chat_message}
        )
      else
        render json: @chat_message.errors, status: unprocessable_entity
      end      
    end
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:message, :chat_id)
  end
end