class CreatePeriodos < ActiveRecord::Migration
  def change
    create_table :periodos do |t|
      t.datetime :inicio
      t.datetime :termino

      t.timestamps null: false
    end
  end
end
