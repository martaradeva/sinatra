# encoding: utf-8
require 'yaml'
require 'erb'

website_body = File.read('..\\html_templates\\home.html.erb')
ideas = YAML.load_file("..\\libraries\\ideas.yml")
rendered_html = ERB.new(website_body).result(binding)
File.write("..\\rubytest\\home.html", rendered_html)