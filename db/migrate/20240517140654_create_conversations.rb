class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :first_id, foreign_key: true
      t.integer :second_id, foreign_key: true

      t.timestamps
    end
  end
end
