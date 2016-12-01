class Trabalho < ActiveRecord::Base
  belongs_to :estudante
  belongs_to :orientador, class_name: 'Professor'
  belongs_to :banca_1, class_name: 'Professor'
  belongs_to :banca_2, class_name: 'Professor'
  
  has_many :pareceres

  accepts_nested_attributes_for :orientador
  accepts_nested_attributes_for :banca_1
  accepts_nested_attributes_for :banca_2

  validates :titulo, presence: true
  validates :estudante, presence: true
  validates :orientador, presence: true

  has_attached_file :arquivo
  validates :arquivo, attachment_presence: true
  validates_attachment_content_type :arquivo, content_type: { content_type: ['application/pdf'] }

end
