class ProfessoresController < ApplicationController
	before_action :set_professor, only: [:destroy]

	def new
		@professor = Professor.new
	end

	def create
		@professor = Professor.new(professor_params)
		@professor.estado_acesso = "Nao Confirmado"
		if @professor.save
			redirect_to admin_professores_path, notice: "Professor salvo com sucesso"
		else
			redirect_to admin_professores_path, alert: "Erro ao salvar"
		end
	end


	private
	def set_professor
		@professor = Professor.find(params[:id])
	end

	def professor_params 
		params.require(:professor).permit(:nome, :email)
	end

end
