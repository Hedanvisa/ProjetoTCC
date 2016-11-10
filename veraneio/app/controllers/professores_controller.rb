class ProfessoresController < ApplicationController
	before_action :set_professor, only: [:destroy]

	def index
	end

	def show
		@trabalhos_orientador = Trabalho.where(orientador: params[:id], estado: "Enviado para Avaliação")
		@trabalhos_banca_1 = Trabalho.where(banca_1: params[:id], estado: "Enviado para Avaliação")
		@trabalhos_banca_2 = Trabalho.where(banca_2: params[:id], estado: "Enviado para Avaliação")
	end

	def new
		@professor = Professor.new
	end

	def create
		@professor = Professor.new(professor_params)
		@professor.password = 'professor'
		@professor.password_confirmation = 'professor'
		@professor.estado_acesso = "Não Confirmado"
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
		params.require(:professor).permit(:nome, :email, :password, :password_confirmation)
	end

end
