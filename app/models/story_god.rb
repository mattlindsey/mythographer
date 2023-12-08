class StoryGod < ApplicationRecord
  belongs_to :story
  belongs_to :god

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
  validates :role, presence: false, inclusion: {in: ROLES}

  # enum role: {"Protagonist" => 0, "Antagonist" => 1, "Deuteragonist" => 2, "Love Interest" => 3, "Confidant" => 4, "Foil" => 5, "Mentor" => 6, "Sidekick" => 7, "Tertiary Character" => 8}
end
