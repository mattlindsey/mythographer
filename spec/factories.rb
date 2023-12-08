FactoryBot.define do
  factory(:mythology) do
    name { "Sample Name" }
    description { "Sample Description" }
  end

  factory(:story) do
    title { "Sample Title" }
    body { "Sample Body" }
    mythology
    creativity { "Balanced" }
  end
end
