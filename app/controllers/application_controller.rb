class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, 'XXX')
    end

    def auth_header
        request.headers['Authorization']
    end

    def decode_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, 'XXX', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def logged_in_user
        if decode_token
            user_id = decode_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!logged_in_user
    end

    def authorized
        if !logged_in?
            render json: {message: "Unauthorized"}, status: :unauthorized
        elsif !@user.account_active
            render json: {message: "Activate your account"}, status: :unauthorized
        end
    end

end
