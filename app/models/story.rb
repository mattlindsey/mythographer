class Story < ApplicationRecord
  belongs_to :mythology

  validates :title, presence: true
  validates :body, presence: true

  has_many :storygods, dependent: :destroy
  accepts_nested_attributes_for :storygods
  has_many :gods, through: :storygod

  CREATIVITY_TEMPS = {
    "Conservative" => 0.2,
    "Balanced" => 0.5,
    "Inventive" => 0.8
  }.freeze
  validates :creativity, presence: true, inclusion: {in: CREATIVITY_TEMPS.keys}

  def creativity_temp
    CREATIVITY_TEMPS[creativity]
  end

  after_update -> {
    begin
      broadcast_replace_to "stories"
    rescue => e
      logger.error "Error occurred during broadcast_replace_to: #{e.message}"
    end
  }
end
