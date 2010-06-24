class Address < ActiveRecord::Base
  belongs_to :list

  LOCATIONS = [
    "Andaman & Nicobar", "Andhra Pradesh", "Arunachal Pradesh", "Assam",
    "Bihar", "Chasttisgarh", "Dadra & Nagar Haveli", "Daman & diu",
    "Delhi", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jammu & Kashmir",
    "Jharkand", "Karnataka", "Kerala", "Lakshadweep", "Madhya Pradesh",
    "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Orissa",
    "Pondicherry", "Punjab", "Rajasthan", "Sikkim", "Tamil nadu", "Tripura",
    "Uttar pradesh", "Uttaranchal", "West Bengal"
  ]

  validates_presence_of     :location
  validates_numericality_of :mobile, :phone, :fax, :greater_than => 8000000000, :allow_blank => true
  validates_length_of       :mobile, :is => 10, :allow_blank => true
  validates_length_of       :fax, :is => 10, :allow_blank => true
  validates_format_of       :email,
                            :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                            :allow_blank => true
end

