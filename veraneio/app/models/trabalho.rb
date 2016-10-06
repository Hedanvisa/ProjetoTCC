class Trabalho < ActiveRecord::Base
  belongs_to :estudante
  belongs_to :orientador, class_name: 'Professor'
  accepts_nested_attributes_for :orientador
  has_one :banca_1, class_name: 'Professor'
  has_one :banca_2, class_name: 'Professor'

  has_attached_file :arquivo
  validates :arquivo, attachment_presence: true
  validates_attachment_content_type :arquivo, content_type: ['application/pdf']
  validates :titulo, presence: true
  validates :estudante, presence: true
  validates :orientador, presence: true
end
