require 'swagger_helper'

describe 'Users API' do

    path '/api/v1/users' do
        post 'Create user' do
            tags 'Users'
            consumes 'application/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    email: {type: :string},
                    nickname: {type: :string},
                    phone: {type: :integer, nullable: true},
                    password: {type: :string}
                },
                required: [ 'email', 'nickname', 'password']
            }

            response '201', 'user created' do
                let(:user) {{ email: 'tomek@gamil.com', nickname: 'tomek', password: '123456'}}
                run_test!
            end

            response '400', 'bad request' do
                let(:user) {{ email: 'wojtek'}}
                run_test!
            end
            response '500', 'server error' do
                let(:user) {'error'}
                run_test!
            end
        end
    end
    path '/api/v1/login' do
        post 'Log in' do
            tags 'Users'
            consumes 'application/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    email: {type: :string},
                    password: {type: :string}
                },
                required: [ 'email','password']
            }
            response '200', 'Log in' do
                schema type: :object,
                properties: {
                    token: {type: :string},
                }
                run_test!
            end
        end
    end
    path '/api/v1/auto_login' do
        get 'Automatic log in' do
            tags 'Users'
            consumes 'application/json'
            security [ Bearer: []]

            response '200', 'log in' do
                let(:Authorization) {'Bearer ' + generate_token}
                run_test!
            end

            response '401', 'Access token is missing or invalid' do
                let(:Authentication) {'Bearer ' + generate_token}
                run_test!
            end
        end
    end
end
