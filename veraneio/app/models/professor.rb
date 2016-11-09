class Professor < Usuario
    has_many :pareceres
    validates_uniqueness_of :nome, allow_blank: true, allow_nil: true
	validates_uniqueness_of :email, allow_blank: true, allow_nil: true
end
