require 'sinatra'
require 'erb'

# class HelloWorldApp < Sinatra::Base
# get '/' do
#   "Hello, world!"
# end

# class HelloWorldApp < Sinatra::Base
# checks for name and puts it in place
get '/?:name?' do
  "Hello, #{params[:name] ? params[:name] : 'world'}!"
end
# end

# get '/' do
#   code = "<%= Time.now %>"
#   erb code
# end

# get '/' do
#   erb :index
# end