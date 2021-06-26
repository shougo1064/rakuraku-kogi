class RenameBoeyColumnToComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :boey, :body
  end
end
