class WelcomeController < ApplicationController
	before_action :authenticate_user!

	def index
		@photos = Photo.all.order('created_at DESC')
	end
end