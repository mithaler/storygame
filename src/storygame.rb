#!/usr/bin/ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sequel'
require 'erubis'
require 'sass'

require './src/config'
require './src/models'

get '/' do
    redirect to('/story/' + (0...8).map{ ('a'..'z').to_a[rand(26)] }.join)
end

get '/story/:story_id' do |story_id|
    @story = Story.where(:id => story_id).first

    if @story.nil?
        @story = Story.new
        @story.id = story_id
        @story.save
    end

    erb :game
end

=begin
Next steps:
1. Player name entry
2. Entering sentences
3. Voting
4. Adding sentences to the story
=end
