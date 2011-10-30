#!/usr/bin/ruby

require 'rubygems'
require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://my.db')

module StorySchema
    def self.up
        DB.create_table :stories do
            primary_key :id
            varchar :url_reference, :size => 128, :null => false, :unique => true
            varchar :title, :size => 128, :default => ''
            text :chatlog, :default => '', :null => false
        end

        DB.create_table :players do
            primary_key :id
            varchar :name, :size => 128, :null => false
            bigint :score, :default => 0, :null => false
            boolean :creator, :default => false
            foreign_key :story_id, :stories
        end

        DB.create_table :sentences do
            primary_key :id
            text :text
            int :votes, :default => 0
            boolean :accepted, :default => false
            foreign_key :player_id, :players
            foreign_key :story_id, :stories
        end
    end

    def self.down
        DB.drop_table :sentences, :players, :stories
    end
end
