class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :owned_lists, class_name: "List", foreign_key: :owner_user_id, dependent: :nullify
  has_many :list_shares, dependent: :destroy
  has_many :shared_lists, through: :list_shares, source: :list

  before_destroy :ensure_no_owned_lists

  private

  def ensure_no_owned_lists
    if owned_lists.exists?
      errors.add(:base, "Cannot delete account with active lists")
      throw(:abort)
    end
  end
end
