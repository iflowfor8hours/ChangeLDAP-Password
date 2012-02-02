require 'rubygems'
require 'sinatra'
require File.dirname(__FILE__) + "/change-pass-web.rb"

log = File.new("sinatra.log", "w")
STDOUT.reopen(log)
STDERR.reopen(log)

run Sinatra::Application
