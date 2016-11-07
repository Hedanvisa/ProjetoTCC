class AddColumnnameToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :estado_acesso, :string
  end
end
