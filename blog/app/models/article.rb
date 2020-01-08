class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 10 }
    validates :content, presence: true, length: { minimum: 40 }
end
