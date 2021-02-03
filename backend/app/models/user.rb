class User < ApplicationRecord
    validates :email, :presence => true,
                      :uniqueness => true,
                      :format => { with: URI::MailTo::EMAIL_REGEXP }
    validates :nickname,  :presence => true,
                      :uniqueness => true
    validates :phone, :numericality => true,
                      :length => { :minumum => 10, :maximum => 15 },
                      :allow_blank => true
    has_secure_password
    validates :password, :length => { in: 6..30 },
                         :presence => true
end
