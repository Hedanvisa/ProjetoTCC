class AddNotaFinalToTrabalhos < ActiveRecord::Migration
  def change
    add_column :trabalhos, :nota_final, :float
  end
end
