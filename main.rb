def r
  load './main.rb'
end

class Game
  def initialize(rounds: 8, slots: 4)
    @board       = Board.new(rounds: rounds, slots: slots) # <- pass here
    @setter      = Setter.new
    @guesser     = Guesser.new
    @max_rounds  = rounds
    @round_count = 0
  end

  def test_pipeline
    # Setup
    @board.display_board
    @board.display_code
    code = @setter.set_combination # Change to allow AI
    @board.update_combination(code)
    @board.display_code

    # Individual Rounds Blocked together for now
    guess = @guesser.guess_combination # Change to allow AI
    @board.update_guess(guess) # Add to Board
    @board.evaluate_guess(guess)
    @board.display_board

    guess = @guesser.guess_combination # Change to allow AI
    @board.update_guess(guess) # Add to Board
    @board.evaluate_guess(guess)
    @board.display_board
  end

  def play_match
    # Setup
    @board.display_board
    @board.display_code
    code = @setter.set_combination # Change to allow AI
    @board.update_combination(code)
    @board.display_code

    while @round_count < @max_rounds
      @round_count += 1
      puts "\nRound #{@round_count} of #{@max_rounds}"

      guess = @guesser.guess_combination
      @board.update_guess(guess)
      won = @board.evaluate_guess(guess)
      @board.display_board

      if won
        puts "Congratulations! The guesser cracked the code in #{@round_count} rounds!"
        return
      end
    end

    puts "Game over! The code was: #{code.join(' | ')}"
  end
end

class Board
  attr_reader :slots

  def initialize(rounds: 8, slots: 4)
    # Stores all guesses (8 rounds, 4 slots each)
    @board = Array.new(rounds) { Array.new(slots, 0) }
    @feedback_board = Array.new(rounds) { Array.new(2, 0) }

    # Stores the secret code
    @code = Array.new(slots, 0)

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

  # Display Board & Feedback side by side
  def display_board
    puts 'Guess Board | Feedback (Exact, Partial)'
    @board.each_with_index do |row, idx|
      feedback = @feedback_board[idx]
      # Use padding so columns align nicely
      guess_str = row.map { |n| n.to_s }.join(' | ')
      feedback_str = feedback.join(' | ')
      puts "#{guess_str}   |   #{feedback_str}"
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

  def set_combination(slots = 4)
    puts "Setter, enter #{slots} numbers (1–6), separated by spaces:"
    gets.chomp.split.map(&:to_i)

    # For now, assume valid input
  end
end

class Guesser
  def initialize
    # Later: decide whether this is human or computer
  end

  def guess_combination(slots = 4)
    puts "Guesser, enter #{slots} numbers (1–6), separated by spaces:"
    gets.chomp.split.map(&:to_i)

    # For now, assume valid input
  end
end

game = Game.new(rounds: 4, slots: 5)
game.play_match
