class Address < ActiveRecord::Base
  belongs_to :list

  has_one :state
  has_one :city

  LOCATIONS = [
    "Andaman & Nicobar", "Andhra Pradesh", "Arunachal Pradesh", "Assam",
    "Bihar", "Chasttisgarh", "Dadra & Nagar Haveli", "Daman & diu",
    "Delhi", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jammu & Kashmir",
    "Jharkand", "Karnataka", "Kerala", "Lakshadweep", "Madhya Pradesh",
    "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Orissa",
    "Pondicherry", "Punjab", "Rajasthan", "Sikkim", "Tamil nadu", "Tripura",
    "Uttar pradesh", "Uttaranchal", "West Bengal"
  ]

  validates_presence_of     :state_id, :city_id
  validates_numericality_of :mobile, :phone, :fax, :greater_than => 8000000000, :allow_blank => true
  validates_length_of       :mobile, :is => 10, :allow_blank => true
  validates_length_of       :fax, :is => 10, :allow_blank => true
  validates_format_of       :email,
                            :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                            :allow_blank => true
  validate  :any_one_of_phone_email_mobile_should_be_present

  private
  def any_one_of_phone_email_mobile_should_be_present
    errors.add_to_base("You should provide atleast one of Phone number or Email or Mobile number.") if email.blank? and phone.blank? and mobile.blank?
  end
end

