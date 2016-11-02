class Admin::ProfessorController < ApplicationController
    layout 'admin'
    
    def index
        @professores = Professor.all
    end

	def edit
		@professor = Professor.find(params[:id])
	end
end
