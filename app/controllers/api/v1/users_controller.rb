module Api
    module V1
        class UsersController < ApplicationController
            before_action :authorized, only: [:auto_login]

            def create
                @user = User.new(user_params)
                @user.role = Role.find(2)
                if @user.save
                    @user.setConfirmationToken
                    @user.save(validate:false)
                    UserMailer.with(user: @user).account_confirm.deliver_later
                    token = encode_token({user_id: @user.id})
                    render json: {message: "User was successfully created!"}, 
                           status: :created
                else
                    render json: {status: 'ERROR', message: 
                                 'Validation failed: ', error: @user.errors},
                         status: :bad_request 
                end
            end

            def login
                @user = User.find_by(email: params[:email])
                if @user && @user.authenticate(params[:password])
                    if !@user.account_active
                        render json: {message: "Activate your account"}, status: :unauthorized
                    else
                        token = encode_token({user_id: @user.id})
                        render json: {user: @user, token: token}, include: [:role], except: 
                        [:password_digest], status: :ok
                    end
                else
                    render json: {status: 'ERROR', message: 'Invalid user name or password'}, 
                           status: :bad_request
                end
            end

            def auto_login
                render json: {user: @user}, include: [:role], except: 
                [:password_digest], status: :ok
            end  
        
            def confirm_email
                user = User.find_by_confirm_token(params[:token])
                if user
                    user.validateEmail
                    user.save(validate: false)
                    redirect_to ENV["FRONT_HOST"] + "/login?activate=true"
                else
                    redirect_to ENV["FRONT_HOST"] + "/login?activate=false"
                end
            end
    
            private

            def user_params
                params.permit(:email, :nickname, :password, :phone)
            end
        end
    end
end
