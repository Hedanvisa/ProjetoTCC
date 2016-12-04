class Admin::EstudantesController < ApplicationController
    layout 'admin'
    
    def index
        @estudantes = Estudante.order('updated_at DESC').all
        @estudante = Estudante.new
    end

    def new

    end

    def create
		@estudante = Estudante.new(nome: params[:nome], email: params[:email], ra: params[:ra], password: "padrao", password_confirmation: "padrao")
		@estudante.exception = false

		@estudante.save
		redirect_to admin_estudantes_path
	end

    def edit
		@estudante = Estudante.find(params[:id])
	end

    def update
        @estudante = Estudante.find(params[:id])
        if @estudante.update estudante_params
            if params[:estudante][:exception][:exception] == "1" and @estudante.exception == false 
                @estudante.exception = true
            else
                @estudante.exception = false
            end
            @estudante.save
            redirect_to admin_estudantes_path, notice: "Estudante atualizado com sucesso"
        else
            redirect_to admin_estudantes_path, alert: "Erro na atualizacao!"
        end
    end

    private
    def estudante_params
        params.require(:estudante).permit(:nome, :email, :ra)
    end
end
