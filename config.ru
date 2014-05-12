class MyAwesomeWebApp
	def call(env)
		new_line = "\n"
		path = env['REQUEST_PATH']
		# path[0] = ""
		# gorniyat red maha pyrviyat red na stringa
		path = path.slice(1..-1)
		content = ["Hello, #{path}!"]
		content << new_line << new_line
		# dobavya new_line sled content
		content << env.map{|key, value| "#{key}:#{value}"}.join(new_line)
		[200, {'Content-Type'   => 'text/plain'}, content]
	end
end

hello_world_app = MyAwesomeWebApp.new

run hello_world_app