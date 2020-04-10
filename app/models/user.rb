class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true
  validates :name, uniqueness: { message: "そのユーザーは既に存在します"}

  has_secure_password

  def correct_answer_count(user)
    (user.highest_rate.to_f / 100) * 50
  end 

  def get_rank(user)
    ranked_ids = User.where('highest_rate IS NOT NULL').order('highest_rate desc').select(:id).map(&:id)
    ranked_ids.index(user.id) + 1
  end
end
