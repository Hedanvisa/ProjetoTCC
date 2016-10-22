class TrabalhosController < ApplicationController
#	before_action :autenticar_usuario!

	def new
		@estudante = Estudante.find(params[:estudante_id])
		@trabalho = @estudante.build_trabalho
		@trabalho.build_orientador
		@trabalho.build_banca_1
		@trabalho.build_banca_2
	end

	def show
		@estudante = Estudante.find(params[:estudante_id])
		@trabalho = @estudante.trabalho
		@orientador = @trabalho.orientador
		@banca_1 = @trabalho.banca_1
		@banca_2 = @trabalho.banca_2

		render 'new'
	end

	def create
		@estudante = Estudante.find(params[:estudante_id])
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
			Notificador.admin_novo_trabalho(@adm, @estudante).deliver_now
			@estudante = Estudante.find(params[:estudante_id])
			Notificador.aluno_novo_trabalho(@trabalho,@estudante).deliver_now
			redirect_to login_path, notice: "Trabalho enviado com sucesso!!!"
		else
			render 'new'
		end
	end
	
	def edit
		@estudante = Estudante.find(params[:estudante_id])
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
end
