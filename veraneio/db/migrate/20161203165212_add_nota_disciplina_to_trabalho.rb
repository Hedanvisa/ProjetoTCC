class AddNotaDisciplinaToTrabalho < ActiveRecord::Migration
  def change
    add_column :trabalhos, :nota_disciplina, :float
  end
end
