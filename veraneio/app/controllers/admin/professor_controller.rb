class Admin::ProfessorController < ApplicationController
    layout 'admin'
    
    def new
        @professor = Professor.new
    end

    def index
        @professor = Professor.new
        @professores = Professor.all
    end

	def edit
		@professor = Professor.find(params[:id])
	end

    def update
        @professor = Professor.find(params[:id])
        if @professor.update professor_params
            redirect_to admin_professor_index_path, notice: "Professor atualizado com sucesso"
        else
            redirect_to admin_professor_index_path, alert: "Erro na atualizacao!"
        end
    end

    private
    def professor_params
        params.require(:professor).permit(:nome, :email)
    end
end
