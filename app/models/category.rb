class Category < ActiveRecord::Base
  has_and_belongs_to_many :lists

  acts_as_nested_set

  validates_presence_of :name
end

