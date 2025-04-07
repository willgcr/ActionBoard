class Task < ApplicationRecord
  belongs_to :list
  belongs_to :completed_by_user, class_name: "User", optional: true

  validates :title, presence: true, length: { maximum: 255 }

  scope :completed, -> { where(completed: true) }
  scope :pending,   -> { where(completed: false) }
end