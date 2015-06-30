class PhotosController < ApplicationController
	
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@photos = current_user.photos.order('created_at DESC')
	end

	def show
		@photo = Photo.find params[:id]
	end

	def new
		@photo = current_user.photos.build
	end

	def edit
		@photo = Photo.find params[:id]
	end

	def create
		@photo = current_user.photos.build(photo_params)
		if @photo.save
			redirect_to user_photo_path(current_user, @photo)
		else
			render 'new'
		end
	end

	def update
		@photo = Photo.find params[:id]
			if @photo.update(photo_params)
				redirect_to user_photo_path(current_user, @photo)
			else
				render 'edit'
			end
	end

	def destroy
		@photo = Photo.find params[:id]
		@photo.destroy

		redirect_to user_photos_path(current_user)
	end

	private
		def photo_params
			params.require(:photo).permit(:public, :image, :caption)
		end
end
