Spree::UserSessionsController.class_eval do

  layout 'application'
  
  before_action :check_user_for_signup, only: [:create, :new]

  private
  
  def check_user_for_signup
    @user ||= Spree::User.new
  end

end