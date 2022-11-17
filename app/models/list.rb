class List < ApplicationRecord
    has_many :bookmarks, dependent: :destroy
    has_many :movies, through: :bookmarks
    validates :name, presence: true, uniqueness: { case_sensitive: false }
end
