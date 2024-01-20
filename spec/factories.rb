FactoryBot.define do
  factory :mythology do
    name { "Sample Name" }
    description { "Sample Description" }
  end

  factory :pantheon do
    name { "Sample Name" }
    description { "Sample Description" }
  end

  factory :god do
    name { "Sample Name" }
    description { "Sample Description" }
    mythology
    pantheon
  end

  factory :story do
    title { "Sample Title" }
    body { "Sample Body" }
    mythology
    creativity { "Balanced" }
    llm_name { "openai" }
    instructions { "Additional stuff" }
  end

  factory :story_god do
    story
    god
    role { "Protagonist" }
  end
end
