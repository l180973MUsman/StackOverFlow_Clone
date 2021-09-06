class Post < ApplicationRecord
    acts_as_votable

    validates :title, presence: true, length: { minimum: 10 }
    validates :body, presence: true, length: { minimum: 10 }
    
    belongs_to :user
    has_many :comments, dependent: :destroy 
end
