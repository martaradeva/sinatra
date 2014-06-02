# encoding: utf-8
require 'yaml'
require 'erb'
require 'sinatra'

# template_path = File.dirname(__FILE__) + '/../html'

before do
content_type :html
@ideas = YAML.load_file("./libraries/ideas.yml")
@header = File.read('./views/header.html')
end

get '/' do
	# index_body = File.read('./views/index.html.erb')
	# rendered_html = ERB.new(index_body).result(binding)
	# File.write("../rubytest/home.html", rendered_html)
	# rendered_html
	erb :"index.html"
end

get '/idea/:number.html' do
	idea_body = File.read('./views/idea_view.html.erb')
	# @ideas[params[:number]]
	rendered_html = ERB.new(idea_body).result(binding)
	# File.write("../rubytest/home.html", rendered_html)
	rendered_html
end

# static pages at end

get '/:static_page.html' do
	# page_template = File.read("./views/#{params[:static_page]}")
	# rendered_html = ERB.new(page_template).result(binding)
	# rendered_html
	url="#{params[:static_page]}.html".to_sym
	erb url
end
