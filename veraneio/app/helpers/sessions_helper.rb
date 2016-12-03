module SessionsHelper
	def log_in(usuario)
		session[:usuario_id] = usuario.id
	end

	def usuario_atual
		@usuario_atual ||= Usuario.find_by( id: session[:usuario_id])
	end

	def log_out(usuario)
		session.delete(:usuario_id)
		@usuario_atual = nil
	end

	def logado?
		!usuario_atual.nil?
	end

	def autenticar_usuario!
		redirect_to login_path unless usuario_atual
	end
end
