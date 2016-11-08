class Admin < Usuario
	validates :nome, presence: true
	validates :email, presence: true
	has_secure_password

def self.table_name
	'admin'
end

end
			


