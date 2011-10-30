#!/usr/bin/ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sequel'
require 'erubis'
require 'sass'

require './src/config'

get '/game/:game_id' do |game_id|
    @game_id = game_id
    erb :game
end
