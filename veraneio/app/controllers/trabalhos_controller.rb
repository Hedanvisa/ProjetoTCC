class TrabalhosController < ApplicationController
	before_action :set_estudante

	def new
		@trabalho = @estudante.build_trabalho
		@trabalho.build_orientador
		@trabalho.build_banca_1
		@trabalho.build_banca_2
	end

	def show
		@trabalho = @estudante.trabalho
		@orientador = @trabalho.orientador
		@banca_1 = @trabalho.banca_1
		@banca_2 = @trabalho.banca_2

		render 'new'
	end

	def create
		@trabalho = @estudante.build_trabalho(trabalhos_param)
		@orientador = Professor.where(email: params[:trabalho][:orientador_attributes][:email]).first
		@banca_1 = Professor.where(nome: params[:trabalho][:banca_1_attributes][:nome]).first
		@banca_2 = Professor.where(nome: params[:trabalho][:banca_2_attributes][:nome]).first

		if @orientador
			@trabalho.orientador = @orientador
		else
			@trabalho.orientador = Professor.create(trabalhos_param[:orientador_attributes])
		end

		if @banca_1
			@trabalho.banca_1 = @banca_1
		else
			@trabalho.banca_1 = Professor.create(trabalhos_param[:banca_1_attributes])
		end

		if @banca_2
			@trabalho.banca_2 = @banca_2
		else
			@trabalho.banca_2 = Professor.create(trabalhos_param[:banca_2_attributes])
		end

		if @trabalho.save 
			@adm = Admin.new nome: "Daniel", email:"danielcostavalerio@gmail.com"
			@estudante = Estudante.find(params[:estudante_id])
			Thread.new do 
				Notificador.admin_novo_trabalho(@adm, @estudante).deliver_now
				Notificador.aluno_novo_trabalho(@trabalho,@estudante).deliver_now
			end
			redirect_to login_path, notice: "Trabalho enviado com sucesso!!!"
		else
			render 'new'
		end
	end
	
	def edit
		@trabalho = @estudante.trabalho
		@trabalho.arquivo.destroy
		@trabalho.arquivo = nil

		render 'new'
	end

	def update
	end

	private
	def trabalhos_param
		params.require(:trabalho).permit(:titulo, :arquivo, orientador_attributes: [:nome, :email], banca_1_attributes: [:nome], banca_2_attributes: [:nome])
	end

	def set_estudante
		@estudante = Estudante.find(params[:estudante_id])
	end
end
