class ChatMessage < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_messages do |t|
      t.string :message
      t.string :role
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
