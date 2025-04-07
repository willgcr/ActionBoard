class List < ApplicationRecord
  belongs_to :owner_user, class_name: "User"

  validates :title, presence: true
  validates :public_uid, presence: true, uniqueness: true

  before_validation :set_public_uid, on: :create

  private

  def set_public_uid
    self.public_uid ||= SecureRandom.uuid
  end
end