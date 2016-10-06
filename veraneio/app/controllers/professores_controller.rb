class ProfessoresController < ApplicationController

	def new
		@professor = Professor.new
	end

	def create
		@professor = Professor.new(professor_params)

		if @professor.save
			rediret_to new_estudante_url, notice: "Salviu"
		else
			redirect_to new_estudante_url, alert: "Vish"
		end
	end


	private

	def professor_params 
		params.require(:professor).permit(:nome, :email)
	end

end
