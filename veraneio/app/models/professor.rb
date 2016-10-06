class Professor < ActiveRecord::Base
	validates :nome, presence: true
	validates :email, uniqueness: true
end
