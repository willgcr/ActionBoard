class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.boolean :completed, default: false, null: false
      t.datetime :completed_at
      t.references :completed_by_user, foreign_key: { to_table: :users }, null: true
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
