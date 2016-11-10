class SessionsController < ApplicationController
	def new
	end

	def create
	  @usuario = Usuario.find_by(email: params[:email])
	  if @usuario && @usuario.authenticate(params[:password])
		session[:usuario_id] = @usuario.id
		if @usuario.class == Estudante
		  redirect_to estudante_trabalho_path estudante_id: @usuario.id, id: @usuario.trabalho
		elsif @usuario.class == Professor
		  redirect_to professor_path @usuario
		elsif @usuario.class == Admin
		  redirect_to admin_trabalhos_path
		end
	  else
		flash.now[:alert]= "Senha ou Email inválido"
		render "new"
	  end
	end

	def destroy
		session[:usuario_id] = nil
		flash[:notice] = "Você foi deslogado."
		redirect_to root_url
	end
end

