#!/usr/bin/ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
require 'sequel'
require 'erubis'
require 'sass'

require './src/config'
require './src/models'

get '/' do
    redirect to('/story/' + (0...8).map{ ('a'..'z').to_a[rand(26)] }.join + '/')
end

before '/story/:story_id/*' do
    @story = Story.where(:url_reference => params[:story_id]).first
end

# Add a closing slash if necessary
get '/story/:story_id' do |story_id|
    redirect to('/story/' + story_id + '/')
end

get '/story/:story_id/' do |story_id|
    if @story.nil?
        @story = Story.new
        @story.url_reference = story_id
        @story.save
    end

    erb :game
end

=begin
Next steps:
1. Player name entry # DONE
2. Entering sentences
3. Voting
4. Adding sentences to the story
=end

# USER DATA SUBMISSION

post '/story/:story_id/post/name', do |story_id|
    @player = Player.where(:name => params[:name]).first

    if @player.nil?
        @player = Player.new
        @player.creator = @story.players.empty?
        @player.story = @story
        @player.name = params[:name]
        @player.save
    end

    {:name => @player.name}.to_json
end
