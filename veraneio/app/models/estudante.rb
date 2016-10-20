class Estudante < Usuario
	has_one :trabalho

	validates :ra, presence: true, uniqueness: true
end
