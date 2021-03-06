# encoding: utf-8
class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authorize
	def new
		@service = Service.new
		@category = Category.new
	end

	def index
		@search = Service.search(params[:q])
    	@service = @search.result
	end

	def edit
		
	end

	def create
		@service = Service.new(service_params)
		respond_to do |format|
			if @service.save
				format.html { redirect_to admin_routes_index_url }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
  		if @service.update(service_params)
  			format.html { redirect_to admin_routes_index_path }
  		else
  			format.html { render :edit }
  		end
  	end
	end

	def destroy
		@service.destroy
		respond_to do |format|
			format.html { redirect_to admin_routes_index_url }
		end

	end

private
  def set_service
    @service = Service.find(params[:id])
  end

	def service_params
		params.require(:service).permit(
      :name,
      :category_id)
	end
end