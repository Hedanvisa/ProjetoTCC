class Notificador < ApplicationMailer
	default from: "danielcostavalerio@gmail.com"

	def envia_email()
		mail(to: "danielcostavalerio@hotmail.com", subject: "enviando email rails")	
	end

	def admin_novo_trabalho(administrador, estudante)
		@estudante = estudante
		@administrador = administrador 
		mail(to: @administrador.email, subject: "Nova atividade no Sistema TCC")
	end

	def aluno_novo_trabalho(trabalho,estudante)
		@estudante = estudante
		@trabalho = trabalho
		mail(to:@estudante.email, subject: "Arquivo #{@trabalho.arquivo_file_name} submetido")
	end
end
