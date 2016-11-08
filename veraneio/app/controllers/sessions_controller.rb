class SessionsController < ApplicationController
	def new
	end

	def create
		@usuario = Usuario.find_by(email: params[:email])
		if @usuario.type == "Estudante"
			if @usuario && @usuario.authenticate(params[:password])
				session[:usuario_id] = @usuario.id
				redirect_to estudante_trabalho_path estudante_id: @usuario.id, id: @usuario.trabalho
			else
				flash.now[:alert]= "Senha ou Email inválido"
				render "new"
			end
		elsif @usuario.type == "Professor"
			if @usuario && @usuario.authenticate(params[:password])
				session[:usuario_id] = @usuario.id
				redirect_to estudante_trabalho_path estudante_id: @usuario.id, id: @usuario.trabalho
			else
				flash.now[:alert]= "Senha ou Email inválido"
				render "new"
			end
		end
	end

	def destroy
		session[:usuario_id] = nil
		flash[:notice] = "Você foi deslogado."
		redirect_to root_url
	end
end

