class List < ActiveRecord::Base
  has_one   :address
  has_and_belongs_to_many :categories, :readonly => true

  validates_presence_of   :name, :url, :description, :address
  validates_uniqueness_of :url
  validates_uri_existence_of :url, :with =>
        /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates_associated :address

  accepts_nested_attributes_for :address, :allow_destroy => true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? }}

  def category_ids=(category_ids)
      category_ids.each do |category|
          id = category['id']
          unless id.blank?
            categories << Category.find(id)
          end
      end
  end
end

