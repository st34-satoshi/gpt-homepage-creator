class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :uuid
      t.text :user_message
      t.text :gpt_message, limit: 16777215
      t.string :user_id
      t.string :reply_token
      t.integer :access_count

      t.timestamps

      t.index :uuid, unique: true
      t.index :user_id
    end
  end
end
