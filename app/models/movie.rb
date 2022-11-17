class Movie < ApplicationRecord
    before_destroy :ensure_no_children

    has_many :bookmarks, dependent: :restrict_with_error
    validates :title, presence: true, uniqueness: true
    validates :overview, presence: true

    private

    def ensure_no_children
      unless self.bookmarks.empty?
        raise ActiveRecord::InvalidForeignKey
        raise ActiveRecord::Rollback
      end
    end
end
