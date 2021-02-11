class User < ApplicationRecord
    belongs_to :role
    has_many :advertisements
    validates :email, :presence => true,
                      :uniqueness => true,
                      :format => { with: URI::MailTo::EMAIL_REGEXP }
    validates :nickname,  :presence => true,
                      :uniqueness => true
    validates :phone, :numericality => true,
                      :length => { :minumum => 10, :maximum => 15 },
                      :allow_blank => true
    has_secure_password
    
    #I have commented it because it makes error while seeds script is executed
    #Should be uncomment in production
    
    #validates :password, :length => { :minimum => 6 }, on: :create

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end                    

    def setConfirmationToken
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end
    
    def validateEmail
        self.account_active = true
        self.confirm_token = nil
    end
end
