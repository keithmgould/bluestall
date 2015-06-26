require 'sinatra'
require 'pi_piper'

set :port, 80
set :environment, :production

include PiPiper

get '/' do
  pin = PiPiper::Pin.new(pin: 7, direction: :in)
  @status = pin.on? ? 'occupied' : 'vacant'
  erb :show
end
