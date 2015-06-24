require 'sinatra'
require 'redis-sinatra'

register Sinatra::Cache

get '/' do
  return 'error' unless params['gender'] && params['floor']
  return 'error' unless %w(men women).include?(params['gender'])

  @status = settings.cache.fetch(build_key)

  erb :show
end

put '/' do
  return 'error' unless params['gender'] && params['floor'] && params['status']
  return 'error' unless %w(men women).include?(params['gender'])
  return 'error' unless %w(occupied vacant).include?(params['status'])

  settings.cache.write(build_key, params['status'])

  params['status']
end

private

def build_key
  "#{params['gender']}.#{params['floor']}"
end
