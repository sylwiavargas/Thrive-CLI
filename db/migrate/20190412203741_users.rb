class Users < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.boolean :experience
      t.boolean :audio?
      t.string :color
      t.timestamps
    end
  end
end
