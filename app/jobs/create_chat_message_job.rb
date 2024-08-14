class CreateChatMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    question_asked = chat_message.message
    chat = chat_message.chat
    chat_message = ChatMessage.create!(role: "system", message: "Loading...", chat: chat)

    Turbo::StreamsChannel.broadcast_append_to(
      "chat_messages_#{chat.id}",
      target: "chat_messages_#{chat.id}",
      partial: "chat_messages/message",
      locals: {chat_message: chat_message}
    ) 
    
      response = client.chat(
				parameters: {
						model: "gpt-3.5-turbo", # Required.
						messages: [{ role: "user", content:question_asked}], # Required.
						temperature: 0.7,
				})
				response = response.dig("choices", 0, "message", "content")	
	
      chat_message.update!(message: response)

      Turbo::StreamsChannel.broadcast_replace_to(
        "chat_messages_#{chat.id}",
        target: "chat_message_#{chat_message.id}",
        partial: "chat_messages/message",
        locals: {chat_message: chat_message}
      )

  end

  private

  def client 
    client = OpenAI::Client.new
  end 


end
