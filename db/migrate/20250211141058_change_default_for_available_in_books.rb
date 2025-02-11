class ChangeDefaultForAvailableInBooks < ActiveRecord::Migration[8.0]
  def change
    change_column_default :books, :available, true
  end
end
