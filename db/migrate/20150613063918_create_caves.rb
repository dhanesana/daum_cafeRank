class CreateCaves < ActiveRecord::Migration
  def change
    create_table :caves do |t|
      t.string :title
      t.float :score
      t.string :url

      t.timestamps null: false
    end
  end
end
