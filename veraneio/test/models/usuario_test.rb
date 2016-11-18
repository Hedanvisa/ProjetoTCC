require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
	def setup
		@estudante = usuarios(:anakin)
		@professor = usuarios(:ben)
	end

	test "estudante e professor nao podem ter mesmo email" do
		@estudante.email = @professor.email
		assert_not @estudante.valid?
	end
end
