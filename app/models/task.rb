class Task < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  belongs_to :category
end
