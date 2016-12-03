class Professores::TrabalhosController < ApplicationController
    layout 'professor'
    require 'my_string'
    
    def index
        @professor = Professor.find(params[:professor_id])
        @trabalhos_orientador = Trabalho.where(orientador: params[:professor_id]).where.not(estado: "Recebido do Aluno")
		@trabalhos_banca_1 = Trabalho.where(banca_1: params[:professor_id]).where.not(estado: "Recebido do Aluno")
		@trabalhos_banca_2 = Trabalho.where(banca_2: params[:professor_id]).where.not(estado: "Recebido do Aluno")
    end

    def verifica_entrada
        params[:trabalho][:nota].numeric? and params[:trabalho][:nota].to_f >= 0 and params[:trabalho][:nota].to_f <= 10
    end

    def create
        @professor = Professor.find(params[:professor_id])
        @trabalho = Trabalho.find(params[:trabalho][:id])

        if params[:trabalho][:nota] == ""
            flash[:notice] = "Campo Nota vazio!"
        

        elsif @trabalho.banca_1.id == @professor.id
            if verifica_entrada
                @trabalho.nota_banca_1 = params[:trabalho][:nota]
                @trabalho.save
            end
        
        elsif @trabalho.banca_2.id == @professor.id
            if verifica_entrada
                @trabalho.nota_banca_2 = params[:trabalho][:nota]
                @trabalho.save
            end
        
        elsif @trabalho.orientador.id == @professor.id
            if verifica_entrada
                @trabalho.nota_orientador = params[:trabalho][:nota]
                @trabalho.save
            end
        end
        
        if @trabalho.avaliado_por_todos?
            @trabalho.estado = "Avaliado"
            @trabalho.save
        else
            @trabalho.estado = "Enviado para Avaliação"
            @trabalho.save
        end
        redirect_to professor_trabalhos_path(params[:professor_id])
    end

    def update

    end


end
