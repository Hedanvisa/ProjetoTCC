class ProfessoresController < ApplicationController
	before_action :set_professor, only: [:destroy]
	layout 'professor'

	def index
	end

	def show
		@professor = Professor.find(params[:id])
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

	def update
        @professor = Professor.find(params[:id])
		@professor.estado_acesso = "Confirmado"
        if @professor.update professor_params
		  	flash[:notice] = "Professor atualizado com sucesso"
			redirect_to professor_path
        else
		  	flash[:alert] = "Erro na atualização"
            redirect_to professor_path
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
