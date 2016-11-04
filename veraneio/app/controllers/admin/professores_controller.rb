class Admin::ProfessoresController < ApplicationController
	before_action :set_professor, only: [:update, :destroy, :edit]
    layout 'admin'
    
    def new
        @professor = Professor.new
    end

    def index
        @professor = Professor.new
        @professores = Professor.all
    end

	def edit
	end

	def destroy
		if @professor.destroy
			redirect_to admin_professores_path, notice: "Professor Excluido"
		else
			redirect_to admin_professores_path, notice: "Erro ao excluir Professor"
		end
	end

    def update
        if @professor.update professor_params
            redirect_to admin_professores_path, notice: "Professor atualizado com sucesso"
        else
            redirect_to admin_professores_path, alert: "Erro na atualizacao!"
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
