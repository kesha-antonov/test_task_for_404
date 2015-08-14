class AddDisciplinesCountToSemesters < ActiveRecord::Migration
  def change
    add_column :semesters, :disciplines_count, :integer, index: true, default: 0
  end
end
