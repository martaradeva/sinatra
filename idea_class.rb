class Idea
	include DataMapper::Resource

	property :id,            Serial
	# property :image_url,     FilePath  FILE UPLOAD LATER
	property :title,         String
	property :description,   Text
	property :author,        String
	property :created_at,    DateTime

	mount_uploader :image, ImageUploader

	has n, :comments
end

class ImageUploader < CarrierWave::Uploader::Base
	def extensions_white_list
		%w(jpg jpeg gif png)
	end

	storage :file
end

class Comment
	include DataMapper::Resource

	property :id,            Serial
	property :description,   Text
	property :author,        String
	property :created_at,    DateTime
	belongs_to :idea
end

DataMapper.finalize