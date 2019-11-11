require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @score = 0
    @word = params[:word]
    @letter = new
    if included?(@word, @letter) == false
      @result = "Letters in your attempt aren't included in the grid"
    else
      english_word?(@word) ? @result = "Well done! Score = #{@score += 10}" : @result = "You lost! Score = #{@score = 0}"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(guess, grid)
  guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end
end
