require 'sinatra'
require 'redis-sinatra'

register Sinatra::Cache

get '/' do
  return 'error' unless params['gender'] && params['floor']
  return 'error' unless %w(men women).include?(params['gender'])

  settings.cache.fetch(build_key)
end

put '/' do
  return 'error' unless params['gender'] && params['floor'] && params['used']
  return 'error' unless %w(men women).include?(params['gender'])

  in_use = params['used'] == 'true' ? 'used' : 'empty'

  settings.cache.write(build_key, in_use)

  in_use
end

private

def build_key
  "#{params['gender']}.#{params['floor']}"
end
