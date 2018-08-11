class AddUserToShortcuts < ActiveRecord::Migration[5.2]
  def change
    add_reference :shortcuts, :user, foreign_key: true
  end
end
