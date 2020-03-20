class Directories < ActiveRecord::Migration[5.0]
  def change
    create_table :directories do |t|
       t.integer :user_id
       t.integer :tip_id
       t.string :label
       t.string :comment
       t.timestamps
    end
  end
end
