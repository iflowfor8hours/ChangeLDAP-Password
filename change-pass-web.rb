require 'rubygems'
require 'sinatra'
require 'changepass'

get '/form' do
  username        = params[:username]
  currentPassword = params[:currentPassword]
  newPassword     = params[:newPassword]
  haml :form
end

post '/form' do
  changepass("#{params[:username]}", "#{params[:currentPassword]}", "#{params[:newPassword]}")
  haml :success
end

error do
  'There was a problem chaning your password: ' +env['sinatra.error'].message
end

