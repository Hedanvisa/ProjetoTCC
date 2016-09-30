require 'test_helper'

class TrabalhoTest < ActiveSupport::TestCase
	def setup
		@trabalho = trabalhos(:one)
	end

	test 'trabalho nao pode ser criado sem titulo' do
		@trabalho.titulo = nil
		assert_not @trabalho.valid?
	end
end
