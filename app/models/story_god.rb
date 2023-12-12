class StoryGod < ApplicationRecord
  belongs_to :story
  belongs_to :god
  # validates :story, presence: true
  # validates :god, presence: true
  validates :story, uniqueness: {scope: :god}
  validates :god, uniqueness: {scope: :story}
  accepts_nested_attributes_for :story

  ROLES = [
    "Protagonist",
    "Antagonist",
    "Deuteragonist",
    "Love Interest",
    "Confidant",
    "Foil",
    "Mentor",
    "Sidekick",
    "Tertiary Character"
  ]
  validates :role, inclusion: {in: ROLES}

  # enum role: {"Protagonist" => 0, "Antagonist" => 1, "Deuteragonist" => 2, "Love Interest" => 3, "Confidant" => 4, "Foil" => 5, "Mentor" => 6, "Sidekick" => 7, "Tertiary Character" => 8}
end
