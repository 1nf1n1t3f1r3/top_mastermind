def r
  load './main.rb'
end

class Game
  def initialize(rounds: 8)
    @board       = Board.new
    @setter      = Setter.new
    # @guesser     = Guesser.new
    @max_rounds  = rounds
    @round_count = 0
  end

  def test_pipeline
    @board.display_board
    @board.display_code
    code = @setter.set_combination
    @board.update_combination(code)
    @board.display_code
  end

  def play_match
    secret_code = @setter.set_combination
    @board.update_combination(secret_code)

    play_round until match_over?

    conclude_match
  end

  private

  def play_round
    @board.display_board

    guess = @guesser.take_guess
    @board.submit_guess(guess) # record the guess
    result = @board.check_guess(guess) # check if it's a win

    @round_count += 1

    if result == :win
      @winner = :guesser
    elsif @round_count < @max_rounds
      puts "Round #{@round_count} complete. Continuing..."
    end
  end

  def match_over?
    @winner == :guesser || @round_count >= @max_rounds
  end

  def conclude_match
    @board.display_board

    if @winner == :guesser
      puts 'Guesser wins!'
    else
      puts 'Setter wins!'
    end
  end
end

class Board
  def initialize
    # Stores all guesses (8 rounds, 4 slots each)
    @board = Array.new(8) { Array.new(4, 0) }

    # Stores the secret code
    @code = [0, 0, 0, 0]

    # Tracks which row will be filled next
    @current_row = 0
  end

  def update_combination(code)
    @code = code
  end

  def update_board(array)
    # Inserts the guess into the next available row
    return if @current_row >= @board.length

    @board[@current_row] = array
    @current_row += 1
  end

  def display_board
    @board.each do |row|
      puts row.join(' | ')
    end
  end

  def display_code
    puts "Secret code: #{@code.join(' | ')}"
  end

  def check_board
    # This method will eventually:
    # - compare guesses to @code
    # - determine if a guess matches exactly (win)
    # - determine if the board is full (loss)
    #
    # For now, this stays unimplemented
  end
end

class Setter
  def initialize
    # Later: decide whether this is human or computer
  end

  def set_combination
    puts 'Setter, enter 4 numbers (1–6), separated by spaces:'
    gets.chomp.split.map(&:to_i)

    # For now, assume valid input
  end
end

#   class Guesser
#     def initialize
#       # This'd be the place where we choose Human/AI, maybe?
#     end

#     def take_guess[array]
#       puts " Guesser, enter a 4-length Array with Numbers 1-6 to guess the secret code"
#     end

game = Game.new
game.test_pipeline
