class Admin::EstudanteController < ApplicationController
    layout 'admin'
    
    def index
        @estudantes = Estudante.all
    end

    def edit
		@estudante = Estudante.find(params[:id])
	end

    def update
        @estudante = Estudante.find(params[:id])
        if @estudante.update estudante_param
            redirect_to admin_estudante_index_path, notice: "Estudante atualizado com sucesso"
        else
            redirect_to admin_estudante_index_path, alert: "Erro na atualizacao!"
        end
    end

    private
    def estudante_param
        params.require(:estudante).permit(:nome, :email)
    end
end
