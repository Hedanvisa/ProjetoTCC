module Admin::PeriodosHelper

	def esta_periodo_aberto?
		if Periodo.order(:termino).last.nil?
			return false
		elsif Time.now < Periodo.order(:termino).last.termino
			return true
		else
			return false
		end
	end

	def ultimo_periodo
		return I18n.l Periodo.order(:termino).last.termino, :format => :long
	end

end
