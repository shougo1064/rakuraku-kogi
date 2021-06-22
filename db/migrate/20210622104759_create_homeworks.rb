class CreateHomeworks < ActiveRecord::Migration[6.0]
  def change
    create_table :homeworks do |t|
      t.string :title
      t.text :body
      t.datetime :action
      t.datetime :deadline
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
