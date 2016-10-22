require 'test_helper'

class TrabalhoTest < ActiveSupport::TestCase
	def setup
		@trabalho = trabalhos(:trabalho_1)
	end

	test 'trabalho nao pode ser criado sem titulo' do
		@trabalho.titulo = nil
		assert_not @trabalho.valid?
	end

	test 'trabalho nao pode ser criado sem orientador' do
		@trabalho.orientador = nil
		assert_not @trabalho.valid?
	end
end
