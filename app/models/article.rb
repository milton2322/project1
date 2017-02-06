class Article < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
    validates_length_of :body, minimum: 5
    validates_uniqueness_of :title
end
