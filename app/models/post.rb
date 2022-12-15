class Post < ApplicationRecord
    validates :title, :author, :text, :likes, presence: true
    validate :count_title_words
    validate :count_author_words
    validates :text, length: {minimum: 1200, maximum: 8000}

    def count_title_words
        unless title.scan(/\ /).length >= 3
            errors.add(:title, "It must be at least 4 words")
        end
        # words = []
        # title.split(' ').each do |word|
        #     words << title
        # end
        # unless words.length >= 4
        #     errors.add(:title, "It must be at least 4 words")
        # end
    end


    def count_author_words
        unless author.scan(/\ /).length >= 1
            errors.add(:author, "It must be at least 2 words")
        end
    end
end
