## codemaker class chooses color sequence
COLOR_OPTIONS = %w[red blue green yellow white black brown]
class Codemaker
  attr_accessor :secret_sequence

  def initialize
    @secret_sequence = [COLOR_OPTIONS[rand(7)], COLOR_OPTIONS[rand(7)], COLOR_OPTIONS[rand(7)], COLOR_OPTIONS[rand(7)]]
  end
end

## codebreaker class guesses sequence
class Codebreaker
  attr_accessor :guess_sequence

  def initialize(name)
    @name = name
    @codebreaker_guesses = []
  end

  def input_guess
    @guess_sequence = []
    i = 0
    while i < 4
      puts "Please enter a color in slot #{i + 1}."
      color = gets.chomp.to_s
      if COLOR_OPTIONS.include?(color)
        guess_sequence.push(color)
        i += 1
      else
        puts 'Please enter a valid color.'
      end
    end
    @codebreaker_guesses.push(guess_sequence)
  end
end

class Game
  attr_accessor :codemaker, :codebreaker

  def initialize(codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @turn_count = 1
    @winner = ''
    @guess_comparison = []
    play_game
  end

  def play_game
    play_round while @turn_count < 13
  end

  def play_round
    puts "This is turn #{@turn_count}"
    @codebreaker.input_guess
    check_guess
    check_win
    @guess_comparison = []
    @turn_count += 1
  end

  def check_guess
    i = 0
    while i < @codemaker.secret_sequence.length
      if @codemaker.secret_sequence[i] == @codebreaker.guess_sequence[i]
        @guess_comparison.push('correct color and position')
      else
        @guess_comparison.push('nothing')
      end
      i += 1
    end
    puts @guess_comparison
  end

  def check_win
    puts 'You win' if @guess_comparison.all? { |element| element == 'correct color and position' }
  end
end

## game runner class, instantiates the other classes and starts the game
class MastermindRunner
  def initialize
    codemaker = Codemaker.new
    codebreaker = Codebreaker.new('Patrick')
    Game.new(codemaker, codebreaker)
  end
end

MastermindRunner.new
