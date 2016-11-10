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

		render 'edit'
	end

	def create
		@trabalho = @estudante.build_trabalho(trabalhos_param)
		@orientador = Professor.where(email: params[:trabalho][:orientador_attributes][:email]).first
		@banca_1 = Professor.where(nome: params[:trabalho][:banca_1_attributes][:nome]).first
		@banca_2 = Professor.where(nome: params[:trabalho][:banca_2_attributes][:nome]).first

		verifica_se_existe_no_banco

		@trabalho.estado = "Recebido do Aluno"

		if @trabalho.save 
			@adm = Admin.new nome: "Daniel", email:"ddanielcostavalerio@gmail.com"
			@estudante = Estudante.find(params[:estudante_id])
			Thread.new do 
				Notificador.admin_novo_trabalho(@adm, @estudante).deliver_now
				Notificador.aluno_novo_trabalho(@trabalho,@estudante).deliver_now
			end
			flash[:notice] = "Trabalho enviado com sucesso!"
			redirect_to login_path
		else
			render 'new'
		end
	end
	
	def edit
		@trabalho = @estudante.trabalho
	end

	def update
		@trabalho = @estudante.trabalho
		@orientador = Professor.where(email: params[:trabalho][:orientador_attributes][:email]).first
		@banca_1 = Professor.where(nome: params[:trabalho][:banca_1_attributes][:nome]).first
		@banca_2 = Professor.where(nome: params[:trabalho][:banca_2_attributes][:nome]).first

		verifica_se_existe_no_banco

		@trabalho.titulo = params[:trabalho][:titulo]
		unless params[:trabalho][:arquivo].nil?
			@trabalho.arquivo = params[:trabalho][:arquivo]
		end
		
		if @trabalho.save
			flash.now[:notice] = "Seu trabalho foi atualizado com sucesso!"
			render :edit
		else
			render :edit
		end
	end

	private
	def trabalhos_param
		params.require(:trabalho).permit(:titulo, :arquivo, orientador_attributes: [:nome, :email], banca_1_attributes: [:nome], banca_2_attributes: [:nome])
	end

	def set_estudante
		@estudante = Estudante.find(params[:estudante_id])
	end

	def verifica_se_existe_no_banco
		puts "banca_1: nil #{@banca_1.nil?}"
		puts "banca_1 so ele: #{@banca_1}"

		puts "Empty: #{trabalhos_param[:banca_1_attributes][:nome].empty?}"
		puts "Nil: #{trabalhos_param[:banca_1_attributes][:nome].nil?}"

		puts "Empty: #{trabalhos_param[:banca_2_attributes][:nome].empty?}"
		puts "Nil: #{trabalhos_param[:banca_2_attributes][:nome].nil?}"

		if @orientador
			@trabalho.orientador = @orientador
		else
		  	@orientador = Professor.new password_digest: BCrypt::Password.create('professor', cost: 4), estado_acesso: "Não Confirmado"
		  	@orientador.nome = trabalhos_param[:orientador_attributes][:nome]
		  	@orientador.email = trabalhos_param[:orientador_attributes][:email]
			@orientador.save
			@trabalho.orientador = @orientador
		end

		if @banca_1
			@trabalho.banca_1 = @banca_1
		elsif !trabalhos_param[:banca_1_attributes][:nome].empty?
		  	@banca_1 = Professor.new password_digest: BCrypt::Password.create('professor', cost: 4), estado_acesso: "Não Confirmado"
		  	@banca_1.nome = trabalhos_param[:banca_1_attributes][:nome]
		  	@banca_1.email = trabalhos_param[:banca_1_attributes][:email]
			@banca_1.save
			@trabalho.banca_1 = @banca_1
		end

		if @banca_2
			@trabalho.banca_2 = @banca_2
		elsif !trabalhos_param[:banca_2_attributes][:nome].empty?
		  	@banca_2 = Professor.new password_digest: BCrypt::Password.create('professor', cost: 4), estado_acesso: "Não Confirmado"
		  	@banca_2.nome = trabalhos_param[:banca_2_attributes][:nome]
		  	@banca_2.email = trabalhos_param[:banca_2_attributes][:email]
			@banca_2.save
			@trabalho.banca_2 = @banca_2
		end
	end
end
