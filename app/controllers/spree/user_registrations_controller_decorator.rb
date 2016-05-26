Spree::UserRegistrationsController.class_eval do

  layout 'application'

  def new
    super
    @user = resource
    @bill_address = Spree::Address.new
  end

  def create
    @user = build_resource(spree_user_params)
    @bill_address = Spree::Address.new(bill_address_params) if bill_address_params.present?
    if resource.save
      set_flash_message :notice, :sign_up
      sign_in :spree_user, @user
      session[:spree_user_signup] = true
      associate_user
      if @bill_address and @bill_address.save
        @user.bill_address = @bill_address
        @user.save
      end
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords(resource)
      render :new
    end
  end

  def bill_address_params
    params.require(:bill_address).permit(:firstname, :lastname, :country_id, :state_id, :city, :address1, :address2, :zipcode, :phone) if params[:bill_address].present?
  end
end

