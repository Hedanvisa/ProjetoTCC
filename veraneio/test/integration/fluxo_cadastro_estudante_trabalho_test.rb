require 'test_helper'

class FluxoCadastroEstudanteTrabalhoTest < ActionDispatch::IntegrationTest
	def setup
		@novo_estudante = Estudante.new nome: "Toni da Silva", email: "tony@tony.com", ra: 235
		@estudante = usuarios(:anakin)
	end
	
	test "cadastro de estudante" do
		get "/cadastro"
		assert_response :success

		post_via_redirect "/estudantes",
			{ estudante: { nome: @novo_estudante.nome, 
				  		   email: @novo_estudante.email,
						   ra: @novo_estudante.ra,
						   password: 'tony',
						   password_confirmation: 'tony' }}

		@novo_estudante = Estudante.last
		assert_equal "/estudantes/#{@novo_estudante.id}/trabalhos/new", path
		assert_response :success
	end
	
	test "login de estudante" do
		get "/login"
		assert_response :success

		post_via_redirect "/login", 
			session: { email: @estudante.email, 
			  		   password: 'root'}

		assert_equal "/estudantes/#{@estudante.id}/trabalhos/#{@estudante.trabalho.id}", path
		assert_response :success
	end

end
