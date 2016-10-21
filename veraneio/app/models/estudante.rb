class Estudante < Usuario
	has_one :trabalho

	has_secure_password
	validates :nome, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true
	validates :ra, presence: true, uniqueness: true
end
