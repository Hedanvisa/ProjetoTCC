class AddTerminoAvaliacaoToPeriodo < ActiveRecord::Migration
  def change
    add_column :periodos, :termino_avaliacao, :DateTime
  end
end
