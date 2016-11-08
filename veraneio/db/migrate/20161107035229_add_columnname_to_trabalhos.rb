class AddColumnnameToTrabalhos < ActiveRecord::Migration
  def change
    add_column :trabalhos, :nota_banca_1, :float
    add_column :trabalhos, :nota_banca_2, :float
    add_column :trabalhos, :nota_orientador, :float
  end
end
