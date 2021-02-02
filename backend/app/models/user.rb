class User < ApplicationRecord
    validates :email, :presence => true,
                      :uniqueness => true
    validates :nickname,  :presence => true,
                      :uniqueness => true
    # validates :phone, :numericality => true,
    #                   :presence => false,
    #                   :length => {:minumum => 10, :maximum => 15}
    has_secure_password
end
