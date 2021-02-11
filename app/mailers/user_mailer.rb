class UserMailer < ApplicationMailer
    def account_confirm
        @user = params[:user]
        mail(to: @user.email, subject: 'Confirm your account to Localex')
    end
end
