require 'test_helper'

class ProfessorTest < ActiveSupport::TestCase
	def setup
		@professor = Professor.new nome: "Teste", email:"teste@email.com"
	end
end

