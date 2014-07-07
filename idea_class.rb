class Idea
	include DataMapper::Resource

	property :id,            Serial
	property :image_url,     FilePath
	property :title,         String
	property :description,   Text
	property :author,        String
	property :date_modified, DateTime
	has n, :comments
end

class Comment
	include DataMapper::Resource

	property :id,            Serial
	property :description,   Text
	property :author,        String
	property :date_modified, DateTime
	belongs_to :idea
end


DataMapper.finalize