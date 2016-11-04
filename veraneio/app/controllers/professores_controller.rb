class ProfessoresController < ApplicationController

	def new
		@professor = Professor.new
	end

	def create
		@professor = Professor.new(professor_params)

		if @professor.save
			redirect_to admin_professores_path, notice: "Professor salvo com sucesso"
		else
			redirect_to admin_professores_path, alert: "Erro ao salvar"
		end
	end


	private

	def professor_params 
		params.require(:professor).permit(:nome, :email)
	end

end
