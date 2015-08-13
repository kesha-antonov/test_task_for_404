class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :study_group, index: true
      t.date :birthday
      t.string :email
      t.string :ip, index: true
      t.datetime :registered_at

      t.timestamps null: false
    end
    add_index :students, [:first_name, :last_name]
  end
end
