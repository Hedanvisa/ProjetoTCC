class Admin::TrabalhosController < ApplicationController
    layout 'admin'

    def index
        @trabalhos = Trabalho.all
        @professores = Professor.all
        @count_recebidos = Trabalho.where(estado: "Recebido do Aluno").count
        @count_avaliacao = Trabalho.where(estado: "Enviado para Avaliação").count
        @count_encaminhado = Trabalho.where(estado: "Encaminhado para o Orientador").count
    end

    def edit
        redirect_to root_path
    end

    def update
        @banca_1 = Professor.where(email: params[:banca_1]).first
        @banca_2 = Professor.where(email: params[:banca_2]).first
        @trabalho = Trabalho.find params[:id]
        @orientador = @trabalho.orientador

		puts(@orientador.email)

        if @trabalho.estado == "Recebido do Aluno"
		
            if @banca_1 == @banca_2 
                Thread.new do
                    Notificador.banca_avaliacao(@trabalho.estudante, @banca_1).deliver_now
                    Notificador.banca_avaliacao(@trabalho.estudante, @banca_2).deliver_now
                end
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
