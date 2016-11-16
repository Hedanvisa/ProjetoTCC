module Admin::PeriodosHelper
	def esta_periodo_aberto?
		if Time.now < Periodo.last.termino
			return true
		else
			return false
		end
	end
end
