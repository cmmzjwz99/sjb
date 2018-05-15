class Api::QuizController < Api::BaseController
  def list
    @matchs=Match.where({})
  end

  def history

  end

  def buy

  end
end