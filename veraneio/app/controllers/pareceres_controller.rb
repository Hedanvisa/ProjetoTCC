class PareceresController < ApplicationController

    def index
        @pareceres = Parecer.where(professor_id: params[:professor_id], trabalho_id: params[:trabalho_id])
    end

    def new
		@parecer = Parecer.new
	end

    def create
		@parecer = Parecer.new(parecer_params)
		
		if @parecer.save
			redirect_to professor_trabalho_pareceres_path, notice: "Professor salvo com sucesso"
		else
			redirect_to professor_trabalho_pareceres_path, alert: "Erro ao salvar"
		end
	end

    def parecer_params 
		params.require(:parecer).permit(:pagina, :texto)
	end
end
