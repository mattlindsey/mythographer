class God < ApplicationRecord
  belongs_to :mythology # , dependent: :restrict_with_error <- gives error on db:setup
  belongs_to :pantheon

  has_many :storygods, dependent: :destroy
end
