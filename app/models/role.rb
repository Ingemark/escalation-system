class Role < ActiveRecord::Base
  attr_accessible :name, :resource_type, :resource_id

  validates :name, presence: true

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  rails_admin do
    navigation_label 'User'

    object_label_method do
      :custom_name_method
    end

    list do
      field :id
      field :name
      field :resource_type
      field :resource
      field :created_at
      field :updated_at
    end
    show do
      field :id
      field :name
      field :resource_type
      field :resource
    end
    edit do
      field :name
      field :resource
    end
  end

  def custom_name_method
    model = self.resource_type.constantize unless self.resource_type.nil?
    object = model.find(self.resource_id) unless self.resource_id.nil?
    object_name = object.name unless object.nil?

    [self.name, self.resource_type, object_name].join(' ').squeeze(' ')
  end
  
  scopify
end
