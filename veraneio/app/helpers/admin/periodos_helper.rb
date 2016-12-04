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

	def esta_periodo_avaliacao_aberto?
		if Periodo.order(:termino_avaliacao).last.nil?
			return false
		elsif Time.now < Periodo.order(:termino_avaliacao).last.termino_avaliacao
			return true
		else
			return false
		end
	end

	def ultimo_periodo
		return I18n.l Periodo.order(:termino).last.termino, :format => :long
	end

	def ultimo_periodo_avaliacao
		return I18n.l Periodo.order(:termino_avaliacao).last.termino_avaliacao, :format => :long
	end

end
