# frozen_string_literal: true

class Message < ActiveRecord::Base
  belongs_to :assistant

  validates :role, presence: true
end
