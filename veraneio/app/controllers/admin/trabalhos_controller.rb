class Admin::TrabalhosController < ApplicationController
    layout 'admin'
    require 'my_string'

    def index
        @trabalhos_recebidos = Trabalho.order('updated_at DESC').all.where(estado: "Recebido do Aluno")
        @trabalhos_enviados = Trabalho.order('updated_at DESC').all.where(estado: "Enviado para Avaliação")
        @trabalhos_avaliados = Trabalho.order('updated_at DESC').all.where(estado: "Avaliado")
        @trabalhos_disponibilizados = Trabalho.order('updated_at DESC').all.where(estado: "Nota Disponibilizada")

        @professores = Professor.all
        @count_recebidos = Trabalho.where(estado: "Recebido do Aluno").count
        @count_avaliacao = Trabalho.where(estado: "Enviado para Avaliação").count
        @count_avaliado = Trabalho.where(estado: "Avaliado").count
        @count_disponivel = Trabalho.where(estado: "Nota Disponibilizada").count
    end

    def edit
        redirect_to root_path
    end

    def verifica_entrada
        params[:trabalho][:nota_disciplina].numeric? and params[:trabalho][:nota_disciplina].to_f >= 0 and params[:trabalho][:nota_disciplina].to_f <= 10
    end

    def update
        @trabalho = Trabalho.find params[:id]
        @estudante = Estudante.where(:trabalho == @trabalho.id).first

        if @trabalho.estado == "Recebido do Aluno"
            @banca_1 = Professor.find_by(id: params[:trabalho][:banca_1])
            @banca_2 = Professor.find_by(id: params[:trabalho][:banca_2])
            @orientador = @trabalho.orientador
            
            if @banca_1.email.nil? or @banca_2.email.nil?
                flash[:alert] = "Algum email vazio!"
            
            elsif @banca_1.email != @banca_2.email and @banca_1.email != @orientador.email and @banca_2.email != @orientador.email
                @trabalho.banca_1 = @banca_1
                @trabalho.banca_2 = @banca_2

                Thread.new do
                    Notificador.banca_avaliacao(@trabalho.estudante, @orientador).deliver_now
                    Notificador.banca_avaliacao(@trabalho.estudante, @banca_1).deliver_now
                    Notificador.banca_avaliacao(@trabalho.estudante, @banca_2).deliver_now
                end
                @trabalho.update estado: "Enviado para Avaliação"
                flash[:notice] = "Trabalho enviado com sucesso!"
            else
                flash[:alert] = "Professores iguais!"
            end

        elsif @trabalho.estado == "Avaliado"

            if params[:trabalho][:nota_disciplina] == ""
                flash[:notice] = "Campo Nota vazio!"
            
            elsif verifica_entrada
                @trabalho.nota_disciplina = params[:trabalho][:nota_disciplina]
                @trabalho.nota_final = ((@trabalho.nota_banca_1 + @trabalho.nota_banca_2)/2 + @trabalho.nota_orientador + @trabalho.nota_disciplina)/3
                @trabalho.save
                @trabalho.update estado: "Nota Disponibilizada"
                flash[:notice] = "Agora o #{@estudante.nome} pode ver sua nota!"
            end
        elsif @trabalho.estado == "Nota Disponibilizada"
            @trabalho.update estado: "Avaliado"
            flash[:notice] = "Trabalho em Revisão"
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
