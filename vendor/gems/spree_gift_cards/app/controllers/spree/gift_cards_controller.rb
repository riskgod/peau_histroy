module Spree
	class GiftCardsController < Spree::StoreController
		def bind_the_user
			id = params[:card_id].to_s
			id = id.split('FEE15')[-1].to_i
			gift_card = Spree::GiftCard.where(code: params[:gift_card][:code], user_id: nil, id: id).first
			if gift_card.present?
				Spree::StoreCredit.create(user_id: spree_current_user.id,amount: gift_card.amount, remaining_amount: gift_card.amount, reason: gift_card.reason)
				gift_card.user_id = spree_current_user.id
				gift_card.save!
				flash[:notice] = "礼品卡成功绑定到您的账号，金额为#{gift_card.amount}元"
			else
				flash[:notice] = "您输入的礼品卡不存在"
			end
			redirect_to '/account'
		end
	end
end