class User < ApplicationRecord
  validates :name, presence: true

  has_secure_password

  scope :sort_by_rate, -> { where('highest_rate IS NOT NULL').order('highest_rate desc') }

  def correct_answer_count
    (highest_rate.to_f / 100) * 50
  end 

  def get_rank
    ranked_rates = User.sort_by_rate.pluck(:highest_rate)
    ranked_ids = User.sort_by_rate.pluck(:id)
    ranks = Array.new(ranked_rates.length,0)

    ranked_rates.each_with_index do |rate, i|
      ranks[i] = 1
      ranked_rates.each_with_index do |rate2, j|
        if rate2 > rate
          ranks[i] += 1
        end
      end
    end

    user_rank = {}
    user_rank = Hash[*([ranked_ids, ranks].transpose.flatten)]
    user_rank[id]
  end
end