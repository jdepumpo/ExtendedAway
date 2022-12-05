class Trip < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates_inclusion_of :entry_type, in: ["Lockbox", "Digital Lock", "Hidden Key", "Other"], message: "%{value} is not a valid entry type"
end
