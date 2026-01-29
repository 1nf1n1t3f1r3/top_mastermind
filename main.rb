def r
  load './main.rb'
end

class Game
  def initialize(rounds: 8)
    @board       = Board.new
    @setter      = Setter.new
    @guesser     = Guesser.new
    @max_rounds  = rounds
    @round_count = 0
  end

  def test_pipeline
    @board.display_board
    @board.display_code
    code = @setter.set_combination # Change to allow AI
    @board.update_combination(code)
    @board.display_code

    guess = @guesser.guess_combination # Change to allow AI
    @board.update_guess(guess) # Add to Board
    @board.evaluate_guess(guess)
    @board.display_board

    guess = @guesser.guess_combination # Change to allow AI
    @board.update_guess(guess) # Add to Board
    @board.evaluate_guess(guess)
    @board.display_board
  end
end

class Board
  def initialize
    # Stores all guesses (8 rounds, 4 slots each)
    @board = Array.new(8) { Array.new(4, 0) }
    @feedback_board = Array.new(8) { Array.new(2, 0) }

    # Stores the secret code
    @code = [0, 0, 0, 0]

    # Tracks which row will be filled next
    @current_row = 0
  end

  def update_combination(code)
    @code = code
  end

  # Inserts the guess into the next available row
  def update_guess(guess)
    return if @current_row >= @board.length

    @board[@current_row] = guess
    @current_row += 1
  end

  # Display Board & Feedback
  def display_board
    @board.each do |row|
      puts row.join(' | ')
    end

    @feedback_board.each do |row|
      puts row.join(' | ')
    end
  end

  def display_code
    puts "Secret code: #{@code.join(' | ')}"
  end

  def evaluate_guess(guess)
    exact_matches = 0
    partial_matches = 0

    # Create copies so we can mark counted numbers
    code_copy = @code.dup
    guess_copy = guess.dup

    # First pass: check exact matches
    guess_copy.each_with_index do |num, idx|
      next unless code_copy[idx] == num

      exact_matches += 1
      # Mark as counted
      code_copy[idx] = guess_copy[idx] = nil
    end

    # Second pass: check partial matches (number exists but in wrong spot)
    guess_copy.compact.each do |num|
      if code_copy.include?(num)
        partial_matches += 1
        code_copy[code_copy.index(num)] = nil # remove counted number
      end
    end

    # Store feedback in @feedback_board
    @feedback_board[@current_row - 1] = [exact_matches, partial_matches]

    puts "Feedback: #{exact_matches} exact, #{partial_matches} partial"
    exact_matches == 4
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

class Guesser
  def initialize
    # Later: decide whether this is human or computer
  end

  def guess_combination
    puts 'Guesser, enter 4 numbers (1–6), separated by spaces:'
    gets.chomp.split.map(&:to_i)

    # For now, assume valid input
  end
end

game = Game.new
game.test_pipeline
