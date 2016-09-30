class Trabalho < ActiveRecord::Base
  belongs_to :estudante
  belongs_to :orientador, class_name: 'Professor'
  belongs_to :banca_1, class_name: 'Professor'
  belongs_to :banca_2, class_name: 'Professor'

  validates :titulo, presence: true
  validates :estudante, presence: true
  validates :orientador, presence: true
  validates :banca_1, presence: true
  validates :banca_2, presence: true
end
