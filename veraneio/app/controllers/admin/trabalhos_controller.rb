class Admin::TrabalhosController < ApplicationController
    layout 'admin'

    def index
        @trabalhos = Trabalho.order('updated_at DESC').all
        @professores = Professor.all
        @count_recebidos = Trabalho.where(estado: "Recebido do Aluno").count
        @count_avaliacao = Trabalho.where(estado: "Enviado para Avaliação").count
        @count_avaliado = Trabalho.where(estado: "Avaliado").count
        @count_disponivel = Trabalho.where(estado: "Disponibilizada a Nota").count
    end

    def edit
        redirect_to root_path
    end

    def update
        @banca_1 = Professor.find_by(id: params[:trabalho][:banca_1])
        @banca_2 = Professor.find_by(id: params[:trabalho][:banca_2])
        @trabalho = Trabalho.find params[:id]
        @orientador = @trabalho.orientador

	    #puts("Email 1 #{@banca_1.email.empty?}")
        #puts("Email 2 #{@banca_2.email.empty?}")

        if @trabalho.estado == "Recebido do Aluno"
            if @banca_1.email.nil? or @banca_2.email.nil?
                flash[:alert] = "Algum email vazio!"
                puts(">>>>>>>>>>> Algum email vazio")
            
            elsif @banca_1.email != @banca_2.email and @banca_1.email != @orientador.email and @banca_2.email != @orientador.email
                @trabalho.banca_1 = @banca_1
                @trabalho.banca_2 = @banca_2

                Thread.new do
                    Notificador.banca_avaliacao(@trabalho.estudante, @orientador).deliver_now
                    Notificador.banca_avaliacao(@trabalho.estudante, @banca_1).deliver_now
                    Notificador.banca_avaliacao(@trabalho.estudante, @banca_2).deliver_now
                end
                puts(">>>>>>>>>>> Enviado para Avaliação")
                @trabalho.update estado: "Enviado para Avaliação"
                flash[:notice] = "Trabalho enviado com sucesso!"
            else
                flash[:alert] = "Professores iguais!"
                puts(">>>>>>>>>>> Prof iguais")
            end
        end
        redirect_to admin_trabalhos_path
    end

	def reenviar_email
		professor = Professor.find(params[:professor_id])
		trabalho = Trabalho.find(params[:trabalho_id])
		Thread.new do
			Notificador.banca_avaliacao(trabalho.estudante, professor).deliver_now
		end
		redirect_to admin_trabalhos_path
	end

    private
    def trabalhos_param
        params.require(:trabalho).permit(:orientador, :banca_1, :banca_2)
    end
end
