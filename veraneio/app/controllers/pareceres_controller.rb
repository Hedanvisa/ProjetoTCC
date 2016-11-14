class PareceresController < ApplicationController

    def index
        @professor = Professor.find(params[:professor_id])
        @trabalho = Trabalho.find(params[:trabalho_id])
        
        if @trabalho.orientador != @professor
            @pareceres = Parecer.where(professor_id: params[:professor_id], trabalho_id: params[:trabalho_id])
        else
            @pareceres = Parecer.where(trabalho_id: params[:trabalho_id])
        end
        @parecer = Parecer.new
    end

    def new
		@parecer = Parecer.new
	end

    def create
        @professor = Professor.find(params[:professor_id])
        @trabalho = Trabalho.find(params[:trabalho_id])
		@parecer = Parecer.new(pagina: params[:parecer][:pagina], texto: params[:parecer][:texto], professor: @professor, trabalho: @trabalho)
		
		if @parecer.save
			redirect_to avaliacao_path, notice: "Parecer salvo com sucesso"
		else
			redirect_to avaliacao_path, alert: "Erro ao salvar"
		end
	end

    def parecer_params 
		params.require(:parecer).permit(:pagina, :texto)
	end
end
