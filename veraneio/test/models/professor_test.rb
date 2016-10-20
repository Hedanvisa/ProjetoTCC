require 'test_helper'

class ProfessorTest < ActiveSupport::TestCase
	def setup
		@professor = Professor.new nome: "Teste", email:"teste@email.com"
	end

   test "professor não pode ser criado sem nome" do
	   assert @professor.valid?
	   @professor.nome = nil
	   assert_not @professor.valid?
   end
end
