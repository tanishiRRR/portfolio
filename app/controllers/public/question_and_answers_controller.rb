class Public::QuestionAndAnswersController < ApplicationController
  before_action :authenticate_end_user!

  def index
    if params[:category_id].present?
      @questions = Question.where(category_id: params[:category_id]).order(created_at: :asc)
    else
      @questions = Question.all.order(created_at: :asc)
    end
  end

  def show
    @question = Question.find(params[:id])
    @supplemental_questions = @question.supplemental_questions.all
  end

end
