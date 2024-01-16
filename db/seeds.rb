# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
["Greek", "Roman", "Norse", "Unspecified"].each do |mythology_name|
  Mythology.find_or_create_by!(name: mythology_name)
end

["Olympian", "Titan", "Primordial", "Asgardian", "None"].each do |pantheon_name|
  Pantheon.find_or_create_by!(name: pantheon_name)
end

m = Mythology.where(name: "Greek").first
p = Pantheon.where(name: "Olympian").first
["Zeus", "Hera", "Poseidon", "Demeter", "Ares", "Athena", "Apollo", "Artemis", "Hephaestus", "Aphrodite", "Hermes", "Dionysus", "Hades", "Hestia"].each do |god_name|
  God.create_with(mythology_id: m.id, pantheon_id: p.id).find_or_create_by!(name: god_name)
end

m = Mythology.where(name: "Roman").first
["Jupiter", "Juno", "Neptune", "Ceres", "Mars", "Minerva", "Apollo", "Diana", "Vulcan", "Venus", "Mercury", "Bacchus", "Pluto", "Vesta"].each do |god_name|
  God.create_with(mythology_id: m.id, pantheon_id: 1).find_or_create_by!(name: god_name)
end

m = Mythology.where(name: "Norse").first
p = Pantheon.where(name: "Asgardian").first
["Odin", "Frigg", "Thor", "Baldr", "Týr", "Njörðr", "Freyr", "Heimdallr", "Bragi", "Víðarr", "Váli", "Loki", "Skaði", "Sigyn"].each do |god_name|
  God.create_with(mythology_id: m.id, pantheon_id: p.id).find_or_create_by!(name: god_name)
end

m = Mythology.where(name: "Greek").first
Story.create_with(mythology_id: m.id, creativity: "Conservative").find_or_create_by(title: "Sample Story with Zeus", body: "The most powerful god Zeus was having a bad day.")
StoryGod.create_with(role: "Protagonist").find_or_create_by(story_id: 1, god_id: 1)
