class AddAttachmentArquivoToTrabalhos < ActiveRecord::Migration
  def self.up
    change_table :trabalhos do |t|
      t.attachment :arquivo
    end
  end

  def self.down
    remove_attachment :trabalhos, :arquivo
  end
end
