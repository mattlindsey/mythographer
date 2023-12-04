# Be sure to restart your server when you modify this file.

LLMS = %w[
  openai,
  google
].freeze

LLM_DEFAULTS = {
  llm: "openai"
}.freeze
