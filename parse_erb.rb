# encoding: utf-8
require 'yaml'
require 'erb'
require 'sinatra'

# template_path = File.dirname(__FILE__) + '/../html'

before do
content_type :html
@ideas = YAML.load_file("./libraries/ideas.yml")
@header = File.read('./html_templates/header.html')
end

get '/' do
	index_body = File.read('./html_templates/index.html.erb')
	rendered_html = ERB.new(index_body).result(binding)
	# File.write("../rubytest/home.html", rendered_html)
	rendered_html
end

get '/#{idea_number}.html' do
	idea_body = File.read('./html_templates/idea_view.html.erb')
	# @ideas[:idea_number]
	rendered_html = ERB.new(idea_body).result(binding)
	# File.write("../rubytest/home.html", rendered_html)
	rendered_html
end

# static pages at end

get '/:static_page' do
	page_template = File.read("./html_templates/#{params[:static_page]}")
	rendered_html = ERB.new(page_template).result(binding)
	rendered_html
end

# get '/upload.html' do
# 	upload_page = File.read('./html_templates/upload.html')
# 	upload_page
# end