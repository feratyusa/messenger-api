class CreateUnreads < ActiveRecord::Migration[6.1]
  def change
    create_table :unreads do |t|
      t.integer :user_id
      t.belongs_to :conversation
      t.belongs_to :text

      t.timestamps
    end
  end
end
