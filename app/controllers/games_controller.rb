require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @score = 0
    @word = params[:word]
    english_word?(@word) ? @result = "Well done! Score = #{@score += 10}" : @result = "You lost! Score = #{@score = 0}"
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
