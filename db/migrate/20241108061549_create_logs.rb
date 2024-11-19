class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|

      t.integer :user_id,      null: false
      t.string :title,         null: false
      t.text :body,            null: false
      t.string :location,      null: false
      t.string :date,          null: false
      t.float :rate,           null: false
      t.integer :price,        null: false, default: 0
      t.integer :public_order, null: false, default: 0
      t.integer :meal,         null: false, default: 0

      t.timestamps
    end
  end
end
