require 'digest/sha1'
require "sinatra"

TOKEN = "nandor"

get '/' do
  params[:echostr]
end

before do
  halt 401 unless valid?(params)
end

def valid?(params)
  signature = params[:signature] || ''
  timestamp = params[:timestamp] || ''
  nonce = params[:nonce] || ''
  Digest::SHA1.hexdigest([TOKEN, timestamp, nonce].sort.join) == signature ? true : false
end

