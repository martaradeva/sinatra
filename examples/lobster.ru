require './lobster'

use Rack::ShowExceptions
run Rack::Lobster.new