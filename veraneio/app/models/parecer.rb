class Parecer < ActiveRecord::Base
  belongs_to :trabalho
  belongs_to :professor

  validates_presence_of :pagina
  validates_presence_of :texto
end
