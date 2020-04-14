class Question < ApplicationRecord
  validates :question, presence: true
  validates :description, presence: true
  
  has_many :question_similar_words
  accepts_nested_attributes_for :question_similar_words, allow_destroy: true                              
  
  scope :search, -> (search_params) do
    return if search_params.blank?

    question_like(search_params[:question])
      .description_like(search_params[:description])
  end
  scope :question_like, -> (question) { where('question LIKE ?', "%#{question}%") if question.present? }
  scope :description_like, -> (description) { where('description LIKE ?', "%#{description}%") if description.present? }
end