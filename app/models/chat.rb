class Chat < ApplicationRecord
  belongs_to :user
  has_many :chat_messages
end
