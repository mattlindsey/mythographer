# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :assistant

  validates :role, presence: true
end
