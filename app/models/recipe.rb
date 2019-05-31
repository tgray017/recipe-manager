class Recipe < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_and_belongs_to_many :ingredients
  alias_attribute :user_id, :creator_id
end