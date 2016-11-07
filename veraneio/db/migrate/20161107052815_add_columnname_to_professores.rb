class AddColumnnameToProfessores < ActiveRecord::Migration
  def change
    add_column :professores, :estado, :string
  end
end
