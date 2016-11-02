class SessionsController < ApplicationController
	def new
	end

	def create
		usuario = Usuario.find_by(email: params[:email])
		if usuario && usuario.authenticate(params[:password])
			session[:usuario_id] = usuario.id
			redirect_to estudante_trabalho_path estudante_id: usuario.id, id: usuario.trabalho, notice: "Bem Vindo"
		else
			flash.now[:alert]= "Senha ou Email inválido"
			render "new"
		end
	end

	def destroy
		session[:usuario_id] = nil
		redirect_to root_url, notice: "Logado com Sucesso"
	end
end

