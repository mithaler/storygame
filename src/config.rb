#!/usr/bin/ruby

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://my.db')
