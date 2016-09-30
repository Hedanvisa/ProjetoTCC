require 'test_helper'

class EstudanteTest < ActiveSupport::TestCase

	def setup
		@e = estudantes(:one)
		@e2 = estudantes(:two)
	end

	test 'estudante nao pode ter nome, email ou ra vazios' do
		@e.nome = nil
		assert_not @e.valid?
	end

	test 'dois estudantes não podem ter mesmo ra' do
		@e = estudantes(:one)
		@e.ra = @e2.ra
		assert_not @e.valid?
	end

end
