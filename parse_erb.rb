# encoding: utf-8
require 'yaml'
require 'erb'
require 'sinatra'
configure :development do
	require 'sinatra/reloader'
end

# template_path = File.dirname(__FILE__) + '/../html'

before do 
content_type :html
@ideas = YAML.load_file("./libraries/ideas.yml")
@header = File.read('./views/header.html')
end

get '/' do
	erb :"index.html"
end

get '/upload' do
	erb :"upload.html"
end

post '/upload.html' do
	@ideas[@ideas.length]=params
	File.write("./libraries/ideas.yml", @ideas.to_yaml)
	redirect to('/')
end

get '/idea/:number/edit.html' do
	@number=params[:number]
	rendered_html = erb :"edit.html"
end

post '/idea/:number/edit.html' do
	idea = {"title" => params["title"], "description" => params["description"], "date_modified" => params["date_modified"]}
	@ideas[params[:number].to_i]=idea
	# da otreje samo nujnite parametri
	File.write("./libraries/ideas.yml", @ideas.to_yaml)
	redirect to('/')
end

get '/idea/:number/delete.html' do
	@ideas.delete("#{params[:number]}".to_i)
	@ideas
	File.write("./libraries/ideas.yml", @ideas.to_yaml)
	redirect to('/')
end

get '/idea/:number.html' do
	@number=params[:number]
	rendered_html = erb :"idea_view.html"
end
# static pages at end

get '/:static_page.html' do
	url="#{params[:static_page]}.html".to_sym
	erb url
end
