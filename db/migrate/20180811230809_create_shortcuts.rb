class CreateShortcuts < ActiveRecord::Migration[5.2]
  def change
    create_table :shortcuts do |t|
      t.string :name
      t.string :path
      t.integer :position

      t.timestamps
    end
  end
end
