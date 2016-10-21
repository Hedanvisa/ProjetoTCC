class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	private

	def current_user
		if session[:usuario_id]
			@usuario_logado ||= Usuario.find(session[:usuario_id])
		end
	end

	helper_method :usuario_logado

	def usuario_logado
		redirect_to login_path unless usuario_logado
	end
end
