class Template < ActiveRecord::Base
  attr_accessible :content, :context_id, :delivery_service_id, :field

  validates :content, :context_id, :delivery_service_id, :field, presence: true
  validates :field, uniqueness: { :scope => [:context_id, :delivery_service_id] }

  belongs_to :context
  belongs_to :delivery_service
end
