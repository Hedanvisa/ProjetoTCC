class Usuario < ActiveRecord::Base
	validates_uniqueness_of :email, allow_blank: true, allow_nil: true
end
