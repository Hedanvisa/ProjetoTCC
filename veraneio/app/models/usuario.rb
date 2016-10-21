class Usuario < ActiveRecord::Base
	has_secure_password
	validates :nome, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
end
