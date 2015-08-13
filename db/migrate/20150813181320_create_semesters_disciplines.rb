class CreateSemestersDisciplines < ActiveRecord::Migration
  def change
    create_table :semesters_disciplines do |t|
      t.references :semester, foreign_key: true
      t.references :discipline, foreign_key: true
      t.integer :mark

      t.timestamps null: false
    end
    add_index :semesters_disciplines, [:semester_id, :discipline_id], unique: true
  end
end
