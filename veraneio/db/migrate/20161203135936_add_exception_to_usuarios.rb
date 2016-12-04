class AddExceptionToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :exception, :boolean
  end
end
