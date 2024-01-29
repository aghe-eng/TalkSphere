class ChangeViewsForUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:users, :views)
      add_column :users, :views, :integer, default: 0
    end
  end
end
