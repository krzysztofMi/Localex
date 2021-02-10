module Api
    module V1
        class AdvertisementsController < ApplicationController
            before_action :authorized, only: [ :create, :update, :destroy ]

            def index
                adds = Advertisement.all()
                render json: {advertisements: adds},
                status: :ok
            end

            def show
                add = Advertisement.find(params[:id])
                render json: {advertisement: add},
                status: :ok
            rescue ActiveRecord::RecordNotFound
                render json: {message: 'not found'},
                status: :not_found
            end

            def create
                add = Advertisement.new(add_params)
                if add.save
                    render json: {advertisement: add},
                    status: :created
                else
                    render json: {status: "ERROR", message: "Not proper fields"},
                    status: :bad_request
                end
            end

            def update
                add = Advertisement.find(params[:id])
                if add.update(add_params)
                    render json: {status: 'SUCCESS', message: "Add updated"},
                    status: :ok
                else
                    render json: {status: "ERROR", message: "Add not updated"},
                    status: :bad_request
                end
            end

            def destroy
                add = Advertisement.find(params[:id])
                add.destroy
                render json: {status: "SUCCESS", message: "Advertisement deleted"},
                status: :ok
            end
            private

            def add_params
                params.permit(:name, :type, :description, :place)
            end
        end
    end
end