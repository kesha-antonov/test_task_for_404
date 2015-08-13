class CreateDiscipline < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :name, default: ''

      t.timestamps null: false
    end
  end
end
