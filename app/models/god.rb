class God < ApplicationRecord
  belongs_to :mythology, dependent: :restrict_with_error
  belongs_to :pantheon

  has_many :storygods, dependent: :destroy
end
