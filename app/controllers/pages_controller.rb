class PagesController < Spree::StoreController
  layout 'application'

  def info
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end
end
