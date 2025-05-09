class List < ApplicationRecord
  belongs_to :owner_user, class_name: "User"
  has_many :list_shares, dependent: :destroy
  has_many :shared_users, through: :list_shares, source: :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validates :public_uid, presence: true, uniqueness: true

  before_validation :set_public_uid, on: :create

  def shared_with?(user)
    shared_users.exists?(user.id)
  end

  private

  def set_public_uid
    self.public_uid ||= SecureRandom.uuid
  end
end
