FactoryBot.define do
  factory(:mythology) do
    name { 'Sample Name' }
    description { 'Sample Description' }
  end

  factory(:story) do
    title { 'Sample Title' }
    body { 'Sample Body' }
    mythology_id { FactoryBot.create(:mythology).id }
  end
end
