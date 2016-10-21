class Admin::ProfessorController < ApplicationController

    def index
        @professores = Professor.all
    end
end