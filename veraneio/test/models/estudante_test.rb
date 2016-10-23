require 'test_helper'

class EstudanteTest < ActiveSupport::TestCase
  def setup
	@estudante_um = usuarios(:anakin)
	@estudante_dois = usuarios(:chewie)
  end

  test "estudante não pode ser criado sem email ou nom" do
	@estudante_um.nome = nil
	assert_not @estudante_um.valid?
	@estudante_um.nome = "Teste"
	@estudante_um.email = nil
	assert_not @estudante_um.valid?
  end

  test "estudantes não podem ter o mesmo email" do
	@estudante_um.email = @estudante_dois.email
	assert_not @estudante_um.valid?
  end
end
