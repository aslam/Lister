class List < ActiveRecord::Base
  has_one   :address
  has_and_belongs_to_many :categories, :readonly => true
  belongs_to :user

  validates_presence_of   :name, :url, :description, :address
  validates_uniqueness_of :url
  validates_uri_existence_of :url, :with =>
        /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  validate :atleast_one_category_must_be_selected
  validates_associated :address

  accepts_nested_attributes_for :address, :allow_destroy => true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? }}


  def atleast_one_category_must_be_selected
    if categories.size == 0
      errors.add_to_base("Atleast one category should be selected!")
    end
  end

  def category_ids=(category_ids)
      category_ids.each do |category|
          id = category['id']
          unless id.blank?
            categories << Category.find(id)
          end
      end
  end
end

