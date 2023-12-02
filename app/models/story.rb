class Story < ApplicationRecord
  belongs_to :mythology
  validates :title, presence: true
  validates :body, presence: true
  validates :creativity, presence: true, inclusion: {in: %w[Conservative Balanced Inventive]}

  after_update -> { broadcast_replace_to "stories" }
end
