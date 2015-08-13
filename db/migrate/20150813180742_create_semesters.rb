class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.integer :name, default: 1, index: true
      t.text :characteristic, default: '', index: true
      t.float :avg_mark, index: true
      t.references :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
