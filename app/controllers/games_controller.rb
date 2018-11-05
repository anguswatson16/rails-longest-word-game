require 'json'
require 'open-uri'
require 'set'

class GamesController < ApplicationController
  def new
    @letters = (0...8).map { (65 + rand(26)).chr }
  end

  def grid_valid(letters)
    grid_array = letters.split(' ')
    @user_word_array = params[:word].upcase.split('')
    @user_set = @user_word_array.to_set
    @letter_set = grid_array.to_set
    @user_set.subset?(@letter_set) == true ? true : false
  end

  def word_valid
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response = open(url).read
    JSON.parse(response)['found'] == true ? true : false
  end

  def score
    # grid_valid
    # word_valid
    if word_valid == false
      @message = 'The word is not in the dictionary.'
    elsif grid_valid(params[:letters]) == false
      @message = 'You used letters that are not in the grid.'
    else
      @message = 'Congratulations! You found a valid word.'
    end
  end
end
