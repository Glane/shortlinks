class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, limit: 30

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
