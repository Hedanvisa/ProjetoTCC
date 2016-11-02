class ProfessoresController < ApplicationController

	def new
		@professor = Professor.new
	end

	def create
		@professor = Professor.new(professor_params)

		if @professor.save
			redirect_to admin_professor_index_path, notice: "Salviu"
		else
			redirect_to admin_professor_index_path, alert: "Vish"
		end
	end


	private

	def professor_params 
		params.require(:professor).permit(:nome, :email)
	end

end
