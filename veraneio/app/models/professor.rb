class Professor < ActiveRecord::Base
	validates :nome, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
end
