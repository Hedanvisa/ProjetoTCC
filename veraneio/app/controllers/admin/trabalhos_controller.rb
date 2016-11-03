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
        @orientador = Professor.where(email: params[:trabalho][:orientador_attributes][:email]).first
		@banca_1 = Professor.where(email: params[:trabalho][:banca_1_attributes][:nome]).first
		@banca_2 = params[:banca_2]

        redirect_to admin_trabalho_index_path
    end

    private
    def trabalhos_param
        params.require(:trabalho).permit(orientador_attributes: [:nome, :email], banca_1_attributes: [:nome], banca_2_attributes: [:nome])
    end
end
