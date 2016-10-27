class Admin::ProfessorController < ApplicationController
    layout 'admin'
    
    def index
        @professores = Professor.all
    end
end