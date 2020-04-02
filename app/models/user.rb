class User < ApplicationRecord
  validate :name_presence
  validate :password_presence
  validates :name, uniqueness: { message: "そのユーザーは既に存在します"}

  has_secure_password

  private

  def name_presence
    return if name.present?
    errors.add(:base, "名前が未入力です")
  end
  def password_presence
    return if password.present? && password_confirmation.present?
    errors.add(:base, "パスワードが未入力です")
  end
end
