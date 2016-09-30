class Estudante < ActiveRecord::Base

	validates :nome, presence: true
	validates :ra, presence: true
	validates :ra, uniqueness: true
	validates :email, presence: true
end
