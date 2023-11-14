# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
["Greek", "Roman", "Norse"].each do |mythology_name|
  Mythology.find_or_create_by!(name: mythology_name)
end

["Olympian", "Titan", "Primordial", "Asgardian", "None"].each do |pantheon_name|
  Pantheon.find_or_create_by!(name: pantheon_name)
end

["Zeus", "Hera", "Poseidon", "Demeter", "Ares", "Athena", "Apollo", "Artemis", "Hephaestus", "Aphrodite", "Hermes", "Dionysus", "Hades", "Hestia"].each do |god_name|
  God.create_with(mythology_id: 1, pantheon_id: 1).find_or_create_by!(name: god_name)
end

["Jupiter", "Juno", "Neptune", "Ceres", "Mars", "Minerva", "Apollo", "Diana", "Vulcan", "Venus", "Mercury", "Bacchus", "Pluto", "Vesta"].each do |god_name|
  God.create_with(mythology_id: 2, pantheon_id: 1).find_or_create_by!(name: god_name)
end

["Odin", "Frigg", "Thor", "Baldr", "Týr", "Njörðr", "Freyr", "Heimdallr", "Bragi", "Víðarr", "Váli", "Loki", "Skaði", "Sigyn"].each do |god_name|
  God.create_with(mythology_id: 3, pantheon_id: 3).find_or_create_by!(name: god_name)
end
