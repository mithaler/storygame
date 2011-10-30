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

# Redirect to a random 8-letter story
get '/' do
    redirect to('/story/' + (0...8).map{ ('a'..'z').to_a[rand(26)] }.join + '/')
end

get '/css/:style.css' do |style|
    scss style.to_sym, :style => :compressed
end

# In all /story/ calls, load the @story first because it'll always be needed
before '/story/:story_id/*' do
    @story = Story.where(:url_reference => params[:story_id]).first
end

# Add a closing slash if necessary
get '/story/:story_id' do |story_id|
    redirect to('/story/' + story_id + '/')
end

get '/story/:story_id/' do |story_id|
    if @story.nil?
        @story = Story.new(:url_reference => story_id).save
    end

    erb :game
end

=begin
Next steps:
2. Entering sentences
3. Voting
4. Adding sentences to the story
=end

# USER DATA SUBMISSION

post '/story/:story_id/post/name' do
    @player = Player.where(:name => params[:name]).first

    if @player.nil?
        @player = Player.new(
            :creator => @story.players.empty?,
            :story => @story,
            :name => params[:name]
        ).save
    else
        @player.name = params[:name]
        @player.save_changes
    end

    {:name => @player.name}.to_json
end
