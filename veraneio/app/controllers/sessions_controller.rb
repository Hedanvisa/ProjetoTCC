class SessionsController < ApplicationController
	def new
	end

	def create
		@usuario = Usuario.find_by(email: params[:session][:email])

		if @usuario && @usuario.authenticate(params[:session][:password])
			log_in @usuario
			if @usuario.class == Estudante
				unless @usuario.trabalho.nil?
					redirect_to estudante_trabalho_path estudante_id: @usuario.id, id: @usuario.trabalho
				else
					redirect_to new_estudante_trabalho_path @usuario
				end
			elsif @usuario.class == Professor
				redirect_to professor_path @usuario
			elsif @usuario.class == Admin
				redirect_to admin_trabalhos_path
			end
		else
			flash[:alert] = "Senha ou Email inválido."
			redirect_to root_path
		end
	end

	def destroy
		log_out @usuario_atual
		flash[:notice] = "Você foi deslogado."
		redirect_to root_path
	end

	private 

	def session_params
		params.require(:session).permit(:email, :password)
	end
end

