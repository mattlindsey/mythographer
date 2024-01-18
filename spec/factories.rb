FactoryBot.define do
  factory :story_god do
  end

  factory(:mythology) do
    name { "Sample Name" }
    description { "Sample Description" }
  end

  factory(:story) do
    title { "Sample Title" }
    body { "Sample Body" }
    mythology
    creativity { "Balanced" }
    llm_name { "openai" }
    instructions { "Additional stuff" }
  end
end
