class Idea
	include DataMapper::Resource

	property :id,            Serial
	# property :image_url,     FilePath  FILE UPLOAD LATER
	property :title,         String
	property :description,   Text
	property :author,        String
	property :created_at,    DateTime
	has n, :comments
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