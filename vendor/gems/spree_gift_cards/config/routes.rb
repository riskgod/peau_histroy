Spree::Core::Engine.routes.draw do
	# resources :gift_cards
	namespace :admin do
	    resources :gift_cards
	end
	resources :gift_cards do
	  collection do
	    post 'bind_the_user'
	  end	   
	end
end
