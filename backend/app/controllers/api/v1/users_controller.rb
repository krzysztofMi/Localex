module Api
    module V1
        class UsersController < ApplicationController
            before_action :authorized, only: [:auto_login]

            def create
                @user = User.new(user_params)
                if @user.save
                    token = encode_token({user_id: @user.id})
                    render json: {token: token}, 
                           status: :created
                else
                    render json: {status: 'ERROR', message: 
                                 'Invalid user name or password', error: @user.errors},
                         status: :bad_request 
                end
            end

            def login
                @user = User.find_by(email: params[:email])
                if @user && @user.authenticate(params[:password])
                    token = encode_token({user_id: @user.id})
                    render json: {token: token}, 
                           status: :ok
                else
                    render json: {status: 'ERROR', message: 'Invalid user name or password'}, 
                           status: :bad_request
                end
            end

            def auto_login
                render json: @user, status: :ok
            end        
            private

            def user_params
                params.permit(:email, :nickname, :password, :phone)
            end
        end
    end
end