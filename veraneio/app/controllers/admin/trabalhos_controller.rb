class Admin::TrabalhosController < ApplicationController
    layout 'admin'

    def index
        @trabalhos = Trabalho.all
        @professores = Professor.all
    end

    def edit
        redirect_to root_path
    end

    def update
        @orientador = Professor.where(email: params[:orientador]).first
        @banca_1 = Professor.where(email: params[:banca_1]).first
        @banca_2 = Professor.where(email: params[:banca_2]).first
        @trabalho = Trabalho.find params[:id]
        
        if @trabalho.estado == "Recebido do Aluno"
            if @banca_1 != @banca_2 
                #Dani, divirta-se aqui

                @trabalho.update estado: "Enviado para Avaliação"
            end
        end

        redirect_to admin_trabalhos_path
    end

    private
    def trabalhos_param
        params.require(:trabalho).permit(:orientador, :banca_1, :banca_2)
    end
end
