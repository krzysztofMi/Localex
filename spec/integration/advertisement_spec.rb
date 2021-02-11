require 'swagger_helper'

describe 'Adds Api' do

    path '/api/v1/advertisements' do
        get "Get all adds" do
            tags 'Adds'
        
            response '200', 'Adds return' do
                run_test!
            end
        end
        post "Create add" do
            tags 'Adds'
            consumes 'application/json'
            security [ Bearer: []]
            parameter name: :add, in: :body, schema: {
                type: :object,
                properties: {
                    name: {type: :string},
                    type: {type: :string, description: 'Free, Exchange or Pay'},
                    description: {type: :string, nullable: true},
                    price: {type: :string, nullable: true},
                    place: {type: :string, nullable: true}
                },
                required: [ 'user_id', 'name', 'type']
            }

            response '201', 'Add created' do
                run_test!
            end

            response '400', 'Bad request' do
                run_test!
            end
        end
    end

    path '/api/v1/advertisements/{id}' do
        parameter name: :id, in: :path, type: :string
        
        get 'Retrive an add' do
            tags 'Adds'
            produces 'application/json'
            response '200', 'Add found' do
                schema type: :object,
                    properties: {
                        user_id: {type: :integer},
                        name: {type: :string},
                        type: {type: :string},
                        description: {type: :integer, nullable: true},
                        place: {type: :string}
                },
                required: ['user_id', 'name', 'type']
                run_test!
            end

            response '404', 'Add not found' do
                run_test!
            end
        end
        
        patch 'Update add' do
            tags 'Adds'
            consumes 'application/json'
            security [ Bearer: []]
            parameter name: :add, in: :body, schema: {
                type: :object,
                properties: {
                    name: {type: :string},
                    type: {type: :string},
                    description: {type: :string, nullable: true},
                    place: {type: :string, nullable: true}
                },
            }

            response '200', 'Add updated' do
                run_test!
            end

            response '400', 'Bad request' do
                run_test!
            end
        end

        delete 'Delete add' do
            tags 'Adds'
            security [ Bearer: []]

            response '200', 'Add removed' do
                run_test!
            end
        end 
    end
end
