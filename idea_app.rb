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
		redirect to('/success.html')
	end

	get '/idea/:id/edit.html' do
		@idea = Idea.get(params[:id])
		erb :"edit.html"
	end

	post '/idea/:id/edit.html' do
		@idea = Idea.get(params[:id])
		@idea.update(
			# :image_url   => params[] -- FILE UPLOAD LATER
			:title       => params["title"],
			:description => params["description"],
			:author      => params["author"],
			:created_at  => Time.now
		)
		@idea.save
		redirect to('/success.html')
	end

	get '/idea/:id/delete.html' do
		@idea=Idea.get(params[:id])
		@idea.destroy
		redirect to('/success.html')
	end

	get '/idea/:id.html' do
		@idea = Idea.get(params[:id])
		erb :"idea_view.html"
	end
	# static pages at end

	get '/:static_page.html' do
		url="#{params[:static_page]}.html".to_sym
		erb url
	end
end
