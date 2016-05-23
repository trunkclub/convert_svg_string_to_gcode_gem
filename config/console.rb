require 'wirb'

Wirb.start
Dir['./lib/**/**/*.rb'].each {|file| require file}
