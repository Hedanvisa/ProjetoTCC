module Admin::PeriodosHelper
	def esta_periodo_aberto?
		if Time.now < Periodo.order(:termino).last.termino
			return true
		else
			return false
		end
	end
end
