module Api
    module V1
        class AdvertisementsController < ApplicationController
            before_action :authorized

            def index
                adds = Advertisement.all()
                render json: {advertisements: adds}    
            end

            def show
                add = Advertisement.find(params[:id])
                render json: {advertisement: add}
            end

            def create
                add = Advertisement.new(add_params)
                if add.save
                    render json: {advertisement: add}
                else
                    render json: {status: "ERROR", message: "Not proper fields"}
                end
            end

            def update
                add = Advertisement.find(params[:id])
                if add.update(add_params)
                    render json: {status: 'SUCCESS', message: "Add updated"}
                else
                    render json: {status: "ERROR", message: "Add not updated"}
                end
            end

            def destroy
                add = Advertisement.find(params[:id])
                add.destroy
                render json: {status: "SUCCESS", message: "Advertisement deleted"}
            end
            private

            def add_params
                params.permit(:name, :type, :description, :place)
            end
        end
    end
end