class Professores::AvaliacaoController < ApplicationController
    layout 'admin'
    def index
        @trabalho = Trabalho.find(1)
    end
end
