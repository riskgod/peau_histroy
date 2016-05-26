module Spree
  module Admin
		class GiftCardsController < Spree::Admin::ResourceController
			def index
			end
			def new
				@gift_card = Spree::GiftCard.new
			end
		  def create
		    number = params[:number].to_i
		    number.times do |i|
		    	puts i
		    	@object = Spree::GiftCard.new
		    	@object.attributes = permitted_resource_params
          @object.save
		    end
	      invoke_callbacks(:create, :after)
	      flash[:success] = flash_message_for(@object, :successfully_created)
	      respond_with(@object) do |format|
	        format.html { redirect_to location_after_save }
	        format.js   { render :layout => false }
	      end
		  end
			private
		  def collection
				@search = Spree::GiftCard.ransack(params[:q])
		    # Spree::GiftCard.order("created_at desc").page(params[:page]).per(Spree::Config[:orders_per_page])
		    @search.result.order("created_at desc").page(params[:page]).per(Spree::Config[:orders_per_page])
		  end
		end	
	end
end	