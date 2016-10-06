class TrabalhosController < ApplicationController
	
	def new
		@estudante = Estudante.find(params[:estudante_id])
		@trabalho = @estudante.build_trabalho
		@trabalho.build_orientador
	end

	def create
		@estudante = Estudante.find(params[:estudante_id])
		@trabalho = @estudante.build_trabalho(trabalhos_param)
		
		if @trabalho.save 
			redirect_to new_estudante_url, notice: "Trabalho enviado com sucesso!!!"
		else
			render 'new'
		end
	end

	private
	def trabalhos_param
		params.require(:trabalho).permit(:titulo, :arquivo, orientador_attributes: [:nome, :email])
	end
end
