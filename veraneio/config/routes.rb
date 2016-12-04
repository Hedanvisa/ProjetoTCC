Rails.application.routes.draw do
	# Rotas para controle de login/logout
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'

	# Rota para cadastro
	get 'cadastro', to: 'estudantes#new', as: 'cadastro'

	# Rota padrao
	root "sessions#new"

	# Rotas das paginas de estudante e seu trabalho
	resources :estudantes, only: [:create, :new, :show, :update] do
		resources :trabalhos, only: [:create, :new, :show, :destroy, :update]
	end

	# Rotas para os professores
	get 'professores/:professor_id/avaliacao/:trabalho_id', to: 'professores/avaliacao#index', as: 'avaliacao'
	resources :professores do
		resources :trabalhos, controller: 'professores/trabalhos' do
			resources :pareceres
		end
	end

	# Rotas para as paginas de Admin
	namespace 'admin' do
		resources :professores
		resources :trabalhos do
		  get 'reenviar_email/:professor_id',to: 'trabalhos#reenviar_email' ,as: 'reenviar'
		end
		resources :estudantes
		resources :periodos
	end

	# Rotas para a leitura de pdf
	mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
end
