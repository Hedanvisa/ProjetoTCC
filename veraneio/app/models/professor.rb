class Professor < Usuario
	validates :nome, presence: true, uniqueness: true
end
