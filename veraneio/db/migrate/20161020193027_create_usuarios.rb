class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :email
      t.string :ra
      t.string :password_digest
      t.string :type

      t.timestamps null: false
    end
  end
end
