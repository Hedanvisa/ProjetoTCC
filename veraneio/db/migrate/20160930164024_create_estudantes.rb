class CreateEstudantes < ActiveRecord::Migration
  def change
    create_table :estudantes do |t|
      t.string :nome
      t.string :email
      t.string :ra

      t.timestamps null: false
    end
  end
end
