class CreateMessageLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :message_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
