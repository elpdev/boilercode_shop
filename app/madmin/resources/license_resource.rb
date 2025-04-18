class LicenseResource < Madmin::Resource
  scope :active
  scope :inactive

  # Attributes
  attribute :id, form: false
  attribute :state
  attribute :user
  attribute :name
  attribute :allowed_users, index: false
  attribute :users_count, form: false
  attribute :created_at, form: false, index: true
  attribute :updated_at, form: false

  # Associations
  attribute :product
  attribute :pay_charge
  attribute :users, label: "GitHub Users"

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
