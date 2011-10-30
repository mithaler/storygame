#!/usr/bin/ruby

require 'rubygems'
require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://my.db')

module StorySchema
    def self.up
        DB.create_table :stories do
            varchar :id, :size => 128, :primary_key => true
            text :chatlog
        end

        DB.create_table :players do
            primary_key :id
            varchar :name, :size => 128
            bigint :score
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
        DB.drop_table :stories, :players, :sentences
    end
end
