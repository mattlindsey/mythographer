class Story < ApplicationRecord
    belongs_to :mythology
    validates :title, presence: true
    validates :body, presence: true
    validates :mythology_id, presence: true

    after_update -> { broadcast_replace_to "stories" }
end
