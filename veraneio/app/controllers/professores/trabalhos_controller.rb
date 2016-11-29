class Professores::TrabalhosController < ApplicationController
    layout 'professor'
    
    def index
        @trabalhos_orientador = Trabalho.where(orientador: params[:professor_id], estado: "Enviado para Avaliação")
		@trabalhos_banca_1 = Trabalho.where(banca_1: params[:professor_id], estado: "Enviado para Avaliação")
		@trabalhos_banca_2 = Trabalho.where(banca_2: params[:professor_id], estado: "Enviado para Avaliação")
    end

    def create
        @trabalho = Trabalho.find(params[:trabalho][:id])
        @trabalho.nota_banca_1 = params[:trabalho][:nota_banca_1]
        @trabalho.save
        redirect_to professor_trabalhos_path(params[:professor_id])
    end

    def update

    end


end
