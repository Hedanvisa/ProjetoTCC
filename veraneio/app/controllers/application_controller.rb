class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	private

	def usuario_atual
		if session[:usuario_id]
			@usuario_atual ||= Usuario.find(session[:usuario_id])
		end
	end

	helper_method :usuario_atual

	def autenticar_usuario!
		redirect_to login_path unless usuario_atual
	end
end
