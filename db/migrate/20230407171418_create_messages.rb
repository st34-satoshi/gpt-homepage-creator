class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :user_message
      t.text :gpt_message, limit: 16777215
      t.string :user_id
      t.string :reply_token

      t.timestamps
    end
  end
end
