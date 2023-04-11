class CreateAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :accesses do |t|
      t.string :ip_address
      t.string :user_agent
      t.string :referer
      t.text :params

      t.timestamps

      t.index :created_at
      t.index :ip_address
    end
  end
end
