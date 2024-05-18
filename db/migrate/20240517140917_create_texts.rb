class CreateTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :texts do |t|
      t.text :message
      t.belongs_to :conversation
      t.belongs_to :user

      t.timestamps
    end
  end
end
