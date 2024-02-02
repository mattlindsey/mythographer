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
  God.create_with(mythology_id: m.id, pantheon_id: p.id).find_or_create_by!(name: god_name)
end

m = Mythology.where(name: "Norse").first
p = Pantheon.where(name: "Asgardian").first
["Odin", "Frigg", "Thor", "Baldr", "Týr", "Njörðr", "Freyr", "Heimdallr", "Bragi", "Víðarr", "Váli", "Loki", "Skaði", "Sigyn"].each do |god_name|
  God.create_with(mythology_id: m.id, pantheon_id: p.id).find_or_create_by!(name: god_name)
end

m = Mythology.where(name: "Greek").first
Story.create_with(mythology_id: m.id, creativity: "Conservative").find_or_create_by(title: "Sample Story with Zeus", body: "The most powerful god Zeus was having a bad day.", llm_name: "openai", instructions: "Zeus is unhappy.")
StoryGod.create_with(role: "Protagonist").find_or_create_by(story_id: 1, god_id: 1)

zeus = God.find_by(name: "Zeus")
zeus.update(description: "The king of the gods, ruler of Mount Olympus, and god of the sky, lightning, and thunder. Zeus is a powerful figure often depicted with a thunderbolt.")
zeus.save

hera = God.find_by(name: "Hera")
hera.update(description: "The queen of the gods, sister, and wife of Zeus. Hera is the goddess of marriage, family, and childbirth.")
hera.save

poseidon = God.find_by(name: "Poseidon")
poseidon.update(description: "God of the sea, earthquakes, and horses. Poseidon is often depicted with a trident, and he controls the oceans.")
poseidon.save

demeter = God.find_by(name: "Demeter")
demeter.update(description: "Goddess of agriculture, harvest, and fertility. Demeter is often associated with the earth's bountiful harvest.")
demeter.save

ares = God.find_by(name: "Ares")
ares.update(description: "God of war, violence, and bloodshed. Ares is a powerful and often feared figure in Greek mythology.")
ares.save

athena = God.find_by(name: "Athena")
athena.update(description: "Goddess of wisdom, warfare, and strategy. Athena is a virgin goddess and is often associated with wisdom and courage.")
athena.save

apollo = God.find_by(name: "Apollo")
apollo.update(description: "God of music, arts, knowledge, healing, and the sun. Apollo is a multi-talented deity often depicted with a lyre.")
apollo.save

artemis = God.find_by(name: "Artemis")
artemis.update(description: "Goddess of the hunt, wilderness, and wild animals. Artemis is a virgin goddess and is often depicted with a bow and arrows.")
artemis.save

hephaestus = God.find_by(name: "Hephaestus")
hephaestus.update(description: "God of fire, blacksmiths, and craftsmen. Hephaestus is the forger of the gods, creating their weapons and armor.")
hephaestus.save

aphrodite = God.find_by(name: "Aphrodite")
aphrodite.update(description: "Goddess of love, beauty, and fertility. Aphrodite is often associated with romance and desire.")
aphrodite.save

hermes = God.find_by(name: "Hermes")
hermes.update(description: "God of travel, trade, and communication. Hermes is a messenger of the gods and is often depicted with winged sandals and a caduceus.")
hermes.save

dionysus = God.find_by(name: "Dionysus")
dionysus.update(description: "God of wine, celebration, and ecstasy. Dionysus is associated with revelry, theater, and the joyous aspects of life.")
dionysus.save

hades = God.find_by(name: "Hades")
hades.update(description: "God of the underworld and the dead. Hades rules over the realm of the afterlife.")
hades.save

hestia = God.find_by(name: "Hestia")
hestia.update(description: "Goddess of the hearth, home, and family. Hestia is a gentle and nurturing deity, often invoked in household rituals.")
hestia.save

jupiter = God.find_by(name: "Jupiter")
jupiter.update(description: "King of the gods, god of the sky and thunder. Equivalent to the Greek god Zeus, Jupiter was considered the chief deity in Roman mythology.")
jupiter.save

juno = God.find_by(name: "Juno")
juno.update(description: "Queen of the gods, goddess of marriage and childbirth. Juno was the wife and sister of Jupiter, similar to the Greek goddess Hera.")
juno.save

neptune = God.find_by(name: "Neptune")
neptune.update(description: "God of the sea. Neptune was the Roman counterpart to the Greek god Poseidon and had control over the oceans.")
neptune.save

ceres = God.find_by(name: "Ceres")
ceres.update(description: "Goddess of agriculture and fertility. Ceres was associated with the harvest and the well-being of crops.")
ceres.save

mars = God.find_by(name: "Mars")
mars.update(description: "God of war. Mars was a significant deity in Roman mythology, often depicted as a fierce and valorous warrior.")
mars.save

minerva = God.find_by(name: "Minerva")
minerva.update(description: "Goddess of wisdom, strategic warfare, and crafts. Minerva was equivalent to the Greek goddess Athena and was associated with intellect and skill.")
minerva.save

apollo = God.find_by(name: "Apollo")
apollo.update(description: "God of music, arts, and prophecy. Apollo was a multifaceted deity, similar to his Greek counterpart, associated with various aspects of culture and knowledge.")
apollo.save

diana = God.find_by(name: "Diana")
diana.update(description: "Goddess of the hunt, wilderness, and the moon. Diana was the Roman equivalent of the Greek goddess Artemis, connected to nature and the moon.")
diana.save

vulcan = God.find_by(name: "Vulcan")
vulcan.update(description: "God of fire, blacksmithing, and craftsmanship. Vulcan was the Roman counterpart to Hephaestus in Greek mythology.")
vulcan.save

venus = God.find_by(name: "Venus")
venus.update(description: "Goddess of love, beauty, and fertility. Venus was similar to the Greek goddess Aphrodite, associated with love and desire.")
venus.save

mercury = God.find_by(name: "Mercury")
mercury.update(description: "God of commerce, travel, and communication. Mercury was the Roman equivalent of Hermes in Greek mythology, serving as a messenger of the gods.")
mercury.save

bacchus = God.find_by(name: "Bacchus")
bacchus.update(description: "God of wine, celebration, and ecstasy. Bacchus was the Roman version of Dionysus, associated with revelry and festivities.")
bacchus.save

pluto = God.find_by(name: "Pluto")
pluto.update(description: "God of the underworld. Pluto ruled over the realm of the dead, similar to the Greek god Hades.")
pluto.save

vesta = God.find_by(name: "Vesta")
vesta.update(description: "Goddess of the hearth and home. Vesta was associated with the sacred fire in the hearth and symbolized home and family.")
vesta.save

odin = God.find_by(name: "Odin")
odin.update(description: "Allfather and chief of the Aesir gods, Odin is associated with wisdom, war, poetry, and magic. He is often depicted as a one-eyed figure, having sacrificed an eye for knowledge.")
odin.save

frigg = God.find_by(name: "Frigg")
frigg.update(description: "Queen of the Aesir and Odin's wife, Frigg is a goddess associated with love, marriage, and motherhood. She is known for her wisdom and foresight.")
frigg.save

thor = God.find_by(name: "Thor")
thor.update(description: "God of thunder, lightning, storms, oak trees, strength, and protection. Thor is one of the most well-known Norse gods, wielding the mighty hammer Mjölnir.")
thor.save

baldr = God.find_by(name: "Baldr")
baldr.update(description: "God of beauty, love, and happiness. Baldr is a gentle and beloved god, known for his beauty and purity.")
baldr.save

tyr = God.find_by(name: "Týr")
tyr.update(description: "God of law, justice, and heroic glory. Týr is often associated with sacrifice and is known for his courage.")
tyr.save

njordr = God.find_by(name: "Njörðr")
njordr.update(description: "God of the sea, seafaring, and wealth. Njörðr is a Vanir god associated with prosperity and the sea.")
njordr.save

freyr = God.find_by(name: "Freyr")
freyr.update(description: "God of fertility, prosperity, and sunlight. Freyr is a Vanir god associated with agriculture and the growth of crops.")
freyr.save

heimdallr = God.find_by(name: "Heimdallr")
heimdallr.update(description: "Guardian of the Bifrost, the rainbow bridge connecting Asgard and Midgard. Heimdallr has acute senses and is often portrayed as the watchman of the gods.")
heimdallr.save

bragi = God.find_by(name: "Bragi")
bragi.update(description: "God of poetry and music. Bragi is associated with eloquence and storytelling, often depicted with a harp.")
bragi.save

vidarr = God.find_by(name: "Víðarr")
vidarr.update(description: "God of vengeance and silence. Víðarr is foretold to avenge Odin's death during Ragnarök and is known for his strength.")
vidarr.save

vali = God.find_by(name: "Váli")
vali.update(description: "God associated with vengeance and survival. Váli was born for the specific purpose of avenging Baldr's death.")
vali.save

loki = God.find_by(name: "Loki")
loki.update(description: "Trickster god and shape-shifter. Loki is a complex figure, known for his mischief and cunning. He is both a friend and adversary to the gods.")
loki.save

skadi = God.find_by(name: "Skaði")
skadi.update(description: "Goddess of winter, mountains, and hunting. Skaði is associated with the cold and is often depicted with skis, representing winter sports.")
skadi.save

sigyn = God.find_by(name: "Sigyn")
sigyn.update(description: "Wife of Loki. Sigyn is known for her loyalty to Loki, even in the face of his misdeeds. She is often associated with endurance and fidelity.")
sigyn.save
