class Story < ApplicationRecord
  belongs_to :mythology
  validates :title, presence: true
  validates :body, presence: true
  validates :creativity, presence: true, inclusion: {in: %w[Conservative Balanced Inventive]}

  CREATIVITY_TEMPS = {
    Conservative: 0.2,
    Balanced: 0.5,
    Inventive: 0.8
  }.freeze

  def creativity_temp
    CREATIVITY_TEMPS[creativity.to_sym]
  end

  after_update -> { broadcast_replace_to "stories" }
end
