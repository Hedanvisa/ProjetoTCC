class EstudantesController < ApplicationController
	def new
		@estudante = Estudante.new
	end

	def create
		@estudante = Estudante.new estudante_params
		@estudante.exception = false

		if @estudante.save
			session[:usuario_id] = @estudante.id
			redirect_to new_estudante_trabalho_url @estudante.id
		else
			render :new
		end
	end

	private

	def estudante_params
		params.require(:estudante).permit(:nome, :email, :ra, :password, :password_confirmation)
	end
end
