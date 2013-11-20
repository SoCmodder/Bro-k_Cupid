class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question Created"
      redirect_to root_url
    end
  end
end
