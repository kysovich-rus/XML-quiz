require_relative 'lib/question'
require_relative 'lib/quiz_manager'
require 'timeout'

puts '[!] Мини-викторина [!]'
puts 'Выберите номер правильного ответа, используя клавиатуру.'
puts

# определение исходников с ответами в подпапке data
data_path = "#{__dir__}/data/questions.xml"

file_data = File.read(data_path)

manager = QuizManager.new
questions_pack = QuizManager.parse_questions(file_data)
questions = QuizManager.sample_questions(questions_pack)

questions.each do |question|
  begin
    Timeout.timeout(question.timer) do
      puts question
      puts question.print_answers

      user_answer = -1

      until question.valid_answer?(user_answer)
        print 'Ответ: '
        user_answer = $stdin.gets.to_i
      end

      if question.correct_answer?(user_answer)
        puts 'Да, вы правы!'
        manager.add_points(question.points)
        manager.increase_counter
      else
        right_index = question.answers.index(question.right_answer) + 1
        puts "Увы, ответ на вопрос - #{right_index}) #{question.right_answer}!"
      end
    end
  rescue Timeout::Error => e
    puts "Время на ответ вышло, незачет!"
  end

  puts
end

puts manager.show_results
