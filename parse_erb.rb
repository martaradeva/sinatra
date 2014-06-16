# encoding: utf-8
require 'yaml'
require 'erb'
require 'sinatra'
require 'sinatra/reloader'

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

get '/idea/:number.html' do
	@number=params[:number]
	p @ideas
	rendered_html = erb :"idea_view.html"
	# idea
end

# static pages at end

get '/:static_page.html' do
	url="#{params[:static_page]}.html".to_sym
	erb url
end
