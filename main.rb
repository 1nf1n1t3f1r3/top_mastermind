def r
  load './main.rb'
end

class Game
  def initialize
    @board=Board.new
    @setter = Setter.new()
    @guesser = Guesser.new()
  end


  def play_match(rounds = 8)
    # Ask the setter to create the secret combination
    secret_code = @setter.set_combination
    @board.update_combination(secret_code)

    rounds.times do
      play_round
      break if match_over?
    end
  end

  def round
  @board.display_board
  move = @guesser.take_a_guess
  new_board = @board.update_board(move)

  result = @board.check_board
  


  if result == win
    puts "Guesser Wins!"
  elsif round_count < rounds
    puts "{round_count} concluded. Continuing to next round"
  else 
    puts "Setter Wins!"
  end 
end

class Board
  def initialize # Empty Board and empty Code
    @board = [
      [0, 0, 0, 0]
      [0, 0, 0, 0]
      [0, 0, 0, 0]
      [0, 0, 0, 0]
      [0, 0, 0, 0]
      [0, 0, 0, 0]
      [0, 0, 0, 0]
      [0, 0, 0, 0]
    ]
    @code =[0, 0, 0, 0]
  end 

  def update_combination[array]
        @code = array
  end

def update_board[array]
  # Updates next array with input array
end

  def display_board
    puts "#{@board[0, 0]} | #{@board[0, 1]} | #{@board[0, 2]} | #{@board[0, 3]}" 
    # Etc...
    # 
    # Need some logic to show how many guesses were correct. Should live here somewhere, right? Not quite sure how to do it yet.
  end

  def check_board
    # if one sub-array is equal to @code
      # win
    # if @board !contains 0 # All spots filled
      # Lose
    
  end
end

  class Setter
    def initialize
      # This'd be the place where we choose Human/AI, maybe?
    end

    def set_combination[array]
          puts "Setter, enter a 4-length Array with Numbers 1-6 to set your secret code" 
      # Set a 4-length array using numbers 1-6
      # Pass that to update_combination
    end
  end

  class Guesser
    def initialize
      # This'd be the place where we choose Human/AI, maybe?
    end

    def take_guess[array]
      puts " Guesser, enter a 4-length Array with Numbers 1-6 to guess the secret code" 
    end  
end