module ApplicationHelper
  
  def tem_alguem_logado
	if usuario_atual
	  return true
	end
	return false
  end
end
