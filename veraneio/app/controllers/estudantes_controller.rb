class EstudantesController < ApplicationController

	def new
		@estudante = Estudante.new
	end

	def create
		@estudante = Estudante.new estudante_params

		if @estudante.save
			redirect_to new_estudante_trabalho_url @estudante.id
		else
			render :new
		end
	end

	private

	def estudante_params
		params.require(:estudante).permit(:nome, :email, :ra, :password)
	end
end
