require 'rexml/document'

class QuizManager
  QUESTION_COUNTER = 5

  def self.parse_questions(file_data)
    doc = REXML::Document.new(file_data)
    elements = doc.get_elements('questions/question')

    elements.map do |question_node|
      Question.new(
        text: question_node.elements['body'].text,
        answers: question_node.get_elements('answers/answer').map(&:text),
        right_answer: question_node.elements['answers/right_answer'].text,
        points: question_node.attributes['points'].to_i,
        timer: question_node.attributes['timer'].to_i
      )
    end
  end

  def self.sample_questions(array)
    array.sample(QuizManager::QUESTION_COUNTER)
  end

  def initialize
    @score = 0
    @count = 0
  end

  def add_points(points)
    @score += points
  end

  def increase_counter
    @count += 1
  end

  def show_results
    "Вы ответили на #{@count}/#{QUESTION_COUNTER} вопросов. Ваш счет - #{@score} б."
  end
end
