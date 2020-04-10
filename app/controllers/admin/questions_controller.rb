class Admin::QuestionsController < ApplicationController

  def index
    @questions = Question.all.includes(:question_similar_words)
    @search_params = question_search_params
    @questions = Question.search(@search_params)

    if  params[:id].present?
      @question = Question.find_by(id: params[:id])
    else
      @question = Question.new
    end
  end

  def create
    @question = Question.new(question_params)
    @question = @question.question_similar_words.build

    if @question.save
      flash[:success] = "単語を登録いたしました"
      redirect_to admin_questions_path 
    else
      flash[:danger] = "単語の登録に失敗しました"
      redirect_to admin_questions_path
    end
  end

  def update
    question = Question.find(params[:id])
    question.update(question_params)
    flash[:success] = "単語を更新いたしました"
    redirect_to admin_questions_path
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    flash[:success] = "単語を削除いたしました"
    redirect_to admin_questions_path
  end


  private

  def question_params
    params.require(:question).permit(:question, :description, question_similar_words_attributes: [:similar_word])
  end

  def question_search_params
    params.fetch(:search, {}).permit(:question, :description)
  end

end