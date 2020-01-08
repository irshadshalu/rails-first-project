class Article < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, presence: true, length: { minimum: 10 }
    validates :content, presence: true, length: { minimum: 40 }
end
