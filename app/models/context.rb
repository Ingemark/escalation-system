class Context < ActiveRecord::Base
  resourcify
  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :escalation_levels, dependent: :destroy
  has_many :templates, dependent: :destroy
end
