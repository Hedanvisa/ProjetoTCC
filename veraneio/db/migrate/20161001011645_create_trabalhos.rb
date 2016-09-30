class CreateTrabalhos < ActiveRecord::Migration
  def change
    create_table :trabalhos do |t|
      t.string :titulo
      t.references :estudante, index: true, foreign_key: true
      t.references :orientador, index: true, foreign_key: true
      t.references :banca_1, index: true, foreign_key: true
      t.references :banca_2, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
