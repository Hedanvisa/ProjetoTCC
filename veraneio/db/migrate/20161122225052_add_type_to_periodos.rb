class AddTypeToPeriodos < ActiveRecord::Migration
  def change
    add_column :periodos, :type, :string
  end
end
