class Admin::TrabalhosController < ApplicationController
    layout 'admin'

    def index
        @trabalhos = Trabalho.all
        @professores = Professor.all
        
    end
end
