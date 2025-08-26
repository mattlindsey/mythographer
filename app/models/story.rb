class Story < ApplicationRecord
  vectorsearch

  after_update -> {
    begin
      broadcast_replace_to "stories"
    rescue => e
      logger.error "Error occurred during broadcast_replace_to: #{e.message}"
    end
  }
  after_save :upsert_to_vectorsearch

  belongs_to :mythology

  validates :title, presence: true
  # validates :body, presence: true
  has_rich_text :content

  has_many :storygods, dependent: :destroy, class_name: "StoryGod"
  accepts_nested_attributes_for :storygods, reject_if: :all_blank, allow_destroy: true
  has_many :gods, through: :storygod

  CREATIVITY_TEMPS = {
    "Conservative" => 0.2,
    "Balanced" => 0.5,
    "Inventive" => 0.8
  }.freeze
  validates :creativity, presence: true, inclusion: {in: CREATIVITY_TEMPS.keys}

  validates :llm_name, presence: true, inclusion: {in: LLMS}

  def creativity_temp
    CREATIVITY_TEMPS[creativity]
  end
end
