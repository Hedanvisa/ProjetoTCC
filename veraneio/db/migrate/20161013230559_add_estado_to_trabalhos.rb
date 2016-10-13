class AddEstadoToTrabalhos < ActiveRecord::Migration
  def change
    add_column :trabalhos, :estado, :string
  end
end
