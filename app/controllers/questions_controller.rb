class QuestionsController < ApplicationController

  def index
    @questions = Question.order("RANDOM()").includes(:question_similar_words).limit(50).pluck(:id, :question, :description, :similar_word)
    respond_to do |format|
      format.html
      format.json {render :json => @questions}
    end
  end
  
end