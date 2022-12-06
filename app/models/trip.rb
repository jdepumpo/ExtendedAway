class Trip < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one_attached :entry_photo
  validates_inclusion_of :entry_type, in: ["Lockbox", "Digital Lock", "Hidden Key", "Other"], message: "%{value} is not a valid entry type"
end
