class ChangeHandleInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :handle, :string, unique: true
  end
end
