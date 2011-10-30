#!/usr/bin/ruby

class Story < Sequel::Model
    one_to_many :players
    one_to_many :sentences

    def accepted_sentences
        self.sentences_dataset.where(:accepted => true).order(:id.asc)
    end
end

class Player < Sequel::Model
    many_to_one :story
end

class Sentence < Sequel::Model
    many_to_one :story
end
