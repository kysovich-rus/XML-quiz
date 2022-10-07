class Question
  attr_reader :answers, :right_answer, :timer, :points

  def initialize(question)
    @text = question[:text]
    @answers = (question[:answers] << question[:right_answer]).shuffle
    @right_answer = question[:right_answer]
    @points = question[:points]
    @timer = question[:timer]
  end

  def to_s
    "#{@text} (#{@points} б.) (Время на ответ: #{@timer}c.)"
  end

  def print_answers
    @answers.each.with_index.map { |answer, i| "#{i + 1}) #{answer}" }
  end

  def valid_answer?(user_answer)
    (1..answers.size).include?(user_answer)
  end

  def correct_answer?(user_answer)
    answers[user_answer - 1] == right_answer
  end
end
