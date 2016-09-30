class Estudante < ActiveRecord::Base
	has_one :trabalho, dependent: :destroy
	has_attached_file :arquivo

	validates :nome, presence: true
	validates :ra, presence: true
	validates :ra, uniqueness: true
	validates :email, presence: true
	validates_attachment :arquivo, attachment_presence: true
end
