class Template < ActiveRecord::Base
  attr_accessible :content, :context_id, :delivery_service_id, :field

  validates :content, :context_id, :delivery_service_id, :field, presence: true
  validates :field, uniqueness: { :scope => [:context_id, :delivery_service_id] }

  belongs_to :context
  belongs_to :delivery_service

  rails_admin do
    navigation_label 'Context'

    configure :content do
      html_attributes rows: 20, cols: 80
    end
  end
end
