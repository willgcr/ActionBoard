class CreateLists < ActiveRecord::Migration[7.1]
  def change
    create_table :lists do |t|
      t.string :title, null: false
      t.string :description, null: true
      t.string :public_uid, null: false, index: { unique: true }
      t.references :owner_user, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
