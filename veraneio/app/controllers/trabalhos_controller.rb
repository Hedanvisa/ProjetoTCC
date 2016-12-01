class TrabalhosController < ApplicationController
	include Admin::PeriodosHelper
	before_action :set_estudante
	before_action :autenticar_usuario!, only: [:edit, :show, :update, :create]

	def new
		@trabalho = @estudante.build_trabalho
		@trabalho.build_orientador
		@trabalho.build_banca_1
		@trabalho.build_banca_2
		@periodo_maximo = Periodo.order(:termino).last
	end

	def show
		@trabalho = @estudante.trabalho
		@orientador = @trabalho.orientador
		@banca_1 = @trabalho.banca_1 || @trabalho.build_banca_1
		@banca_2 = @trabalho.banca_2 || @trabalho.build_banca_2
		@periodo_maximo = Periodo.order(:termino).last

		respond_to do |format|
			format.html { render 'edit' } 
		end
	end

	def create
		@horario_servidor = DateTime.now
		@periodo_maximo = Periodo.order(:termino).last.termino
		@trabalho = @estudante.build_trabalho(titulo: params[:trabalho][:titulo], arquivo: params[:trabalho][:arquivo])
		@orientador = Professor.where(email: params[:trabalho][:orientador_attributes][:email]).first
		@banca_1 = Professor.where(nome: params[:trabalho][:banca_1_attributes][:nome]).first
		@banca_2 = Professor.where(nome: params[:trabalho][:banca_2_attributes][:nome]).first

		verifica_se_existe_no_banco

		@trabalho.estado = "Recebido do Aluno"

		if @trabalho.save 
			@adm = Admin.first
			Thread.new do 
				Notificador.admin_novo_trabalho(@adm, @estudante).deliver_now
				Notificador.aluno_novo_trabalho(@trabalho,@estudante).deliver_now
			end
			log_out @usuario_atual
			flash[:notice] = "Trabalho enviado com sucesso!"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		@trabalho = @estudante.trabalho
		@trabalho.banca_1 ||= @trabalho.build_banca_1
		@trabalho.banca_2 ||= @trabalho.build_banca_2
	end

	def update
		@horario_servidor = DateTime.now
		@periodo_maximo = Periodo.order(:termino).last.termino
		@trabalho = @estudante.trabalho
		@orientador = Professor.find_by(email: params[:trabalho][:orientador_attributes][:email])
		@banca_1 = Professor.find_by(nome: params[:trabalho][:banca_1_attributes][:nome])
		@banca_2 = Professor.find_by(nome: params[:trabalho][:banca_2_attributes][:nome])

		verifica_se_existe_no_banco

		@trabalho.titulo = params[:trabalho][:titulo]
		unless params[:trabalho][:arquivo].nil?
			@trabalho.arquivo = params[:trabalho][:arquivo]
		end

		respond_to do |format|
			if (@periodo_maximo >= @horario_servidor) and @trabalho.save
				flash.now[:notice] = "Seu trabalho foi atualizado com sucesso!"
				format.html { redirect_to estudante_trabalho_path @estudante, @trabalho }
			else
				format.html { render :edit }
			end
		end
	end

	private
	def trabalhos_param
		params.require(:trabalho).permit(:id, :titulo, :arquivo, orientador_attributes: [:nome, :email], banca_1_attributes: [:nome], banca_2_attributes: [:nome])
	end

	def set_estudante
		@estudante = Estudante.find(params[:estudante_id])
	end

	def verifica_se_existe_no_banco
		unless @orientador.nil?
			@trabalho.orientador = @orientador
		else
			@orientador = Professor.where(nome: trabalhos_param[:orientador_attributes][:nome]).first
			if @orientador
				@orientador.email = trabalhos_param[:orientador_attributes][:email]
			else
				@orientador = Professor.new password_digest: BCrypt::Password.create('professor', cost: 4), estado_acesso: "Não Confirmado"
				@orientador.nome = trabalhos_param[:orientador_attributes][:nome]
				@orientador.email = trabalhos_param[:orientador_attributes][:email]
			end
			@orientador.save
			@trabalho.orientador = @orientador
		end

		if !@banca_1.nil?
			@trabalho.banca_1 = @banca_1
		elsif !params[:trabalho][:banca_1_attributes][:nome].empty?
			@banca_1 = Professor.new password_digest: BCrypt::Password.create('professor', cost: 4), estado_acesso: "Não Confirmado"
			@banca_1.nome = trabalhos_param[:banca_1_attributes][:nome]
			@banca_1.save
			@trabalho.banca_1 = @banca_1
		end

		if !@banca_2.nil?
			@trabalho.banca_2 = @banca_2
		elsif !params[:trabalho][:banca_2_attributes][:nome].empty?
			@banca_2 = Professor.new password_digest: BCrypt::Password.create('professor', cost: 4), estado_acesso: "Não Confirmado"
			@banca_2.nome = trabalhos_param[:banca_2_attributes][:nome]
			@banca_2.save
			@trabalho.banca_2 = @banca_2
		end
	end
end
