class Admin::EstudanteController < ApplicationController
    layout 'admin'
    
    def index
        @estudantes = Estudante.all
    end
end
