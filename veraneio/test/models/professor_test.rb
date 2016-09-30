require 'test_helper'

class ProfessorTest < ActiveSupport::TestCase

	def setup
		@p = professores(:one)
		@p2 = professores(:two)
	end

	test 'professor nao pode ter nome ou email' do
		@p.nome = nil
		assert_not @p.valid?
	end

	test 'dois professores não podem ter mesmo email ou nome' do
		@p = professores(:one)
		@p.email = @p2.email
		assert_not @p.valid?
	end

end
