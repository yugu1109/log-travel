class CreateLogComments < ActiveRecord::Migration[6.1]
  def change
    create_table :log_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :log_id

      t.timestamps
    end
  end
end
