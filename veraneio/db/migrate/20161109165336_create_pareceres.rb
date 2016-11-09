class CreatePareceres < ActiveRecord::Migration
  def change
    create_table :pareceres do |t|
      t.integer :pagina
      t.string :texto
      t.references :trabalho, index: true, foreign_key: true
      t.references :professor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
