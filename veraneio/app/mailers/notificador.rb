class Notificador < ApplicationMailer
	default from: "danielcostavalerio@gmail.com"

	def envia_email()
		mail(to: "danielcostavalerio@hotmail.com", subject: "enviando email rails")	
	end

	def admin_novo_trabalho(usuario, estudante)
		@estudante = estudante
		mail(to:usuario.email, subject: "Trabalho de TCC cadastrado")
	end

	def aluno_novo_trabalho(usuario)
		mail(to:usuario.email, subject: "Seu trabalho de TCC foi enviado")
	end
end
