require 'sinatra/base'
# encoding: utf-8
	require 'yaml'
	require 'erb'
	require 'sinatra'
	require 'data_mapper'
	require 'dm-migrations'
	require './idea_class'
	require 'SQLite3'

db_path = "sqlite://#{File.expand_path('.')}/libraries/ideas.db"
# puts db_path
DataMapper.setup(:default, db_path) # A Sqlite3 connection to a persistent database
# DataMapper.auto_migrate!
DataMapper.auto_upgrade! # refreshes databases without deleting entries

class IdeaApp < Sinatra::Application

	configure :development do
		require 'sinatra/reloader'
	end


	before do
	
	content_type :html
	@ideas = Idea.all
	@header = File.read('./views/header.html')
	@idea = Idea.new
	end

	get '/' do
		erb :"index.html"
		# @ideas.inspect
	end

	get '/upload' do
		erb :"upload.html"
	end

	post '/upload.html' do
		@idea = Idea.create(
			# :image_url   => params[] -- FILE UPLOAD LATER
			:title       => params["title"],
			:description => params["description"],
			:author      => params["author"],
			:created_at  => Time.now
		)
		# @idea.save
		# @ideas[@ideas.length]=params
		# File.write("./libraries/ideas.yml", @ideas.to_yaml)
		# "Idea Successfully uploaded"
		# Wait 400
		redirect to('/')
	end

	get '/idea/:number/edit.html' do
		@number=params[:number]
		rendered_html = erb :"edit.html"
	end

	post '/idea/:number/edit.html' do
		@idea = Idea.create(
			# :image_url   => params[] -- FILE UPLOAD LATER
			:id          => params[:number],
			:title       => params["title"],
			:description => params["description"],
			:author      => params["author"],
			:created_at  => Time.now
		)
		@idea.save

		# idea = {"title" => params["title"], "description" => params["description"], "date_modified" => params["date_modified"], "author" => params["author"]}
		# @ideas[params[:number].to_i]=idea
		# # da otreje samo nujnite parametri
		# File.write("./libraries/ideas.yml", @ideas.to_yaml)
		redirect to('/')
	end

	get '/idea/:number/delete.html' do
		@ideas.delete(params[:number].to_i)
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
end
