#!/usr/bin/ruby

class Story < Sequel::Model
    one_to_many :players
    one_to_many :sentences
end

class Player < Sequel::Model
    many_to_one :story
end

class Sentence < Sequel::Model
    many_to_one :story
end
