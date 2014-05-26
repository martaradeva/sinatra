# encoding: utf-8
require 'yaml'
require 'erb'
require 'sinatra'


get '/index.html' do
	index_body = File.read('.\\html_templates\\index.html.erb')
	ideas = YAML.load_file(".\\libraries\\ideas.yml")
	rendered_html = ERB.new(index_body).result(binding)
	# File.write("..\\rubytest\\home.html", rendered_html)
	rendered_html
end

get '/#{idea_number}.html' do
	idea_body = File.read('.\\html_templates\\idea_view.html.erb')
	ideas = YAML.load_file(".\\libraries\\ideas.yml")
	ideas[:idea_number]
	rendered_html = ERB.new(idea_body).result(binding)
	# File.write("..\\rubytest\\home.html", rendered_html)
	rendered_html
end

get '/about.html' do
	about_page = File.read('.\\html_templates\\about.html')
	about_page
end

get '/upload.html' do
	upload_page = File.read('.\\html_templates\\upload.html')
	upload_page
end