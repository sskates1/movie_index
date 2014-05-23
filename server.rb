require_relative "movie_methods"
require_relative "redis_methods"
require 'sinatra'
require 'csv'

all_movies =read_movies_csv('movies.csv')
all_movies = all_movies.sort_by {|row| row[:title]}

get '/' do
  "Hello Index"
end

get '/movies' do
  @page = params[:page] || 1
  @page = @page.to_i
  offset = ((@page-1)*20)

  @search = params[:query]
  @all_movies= all_movies

  if @search
    @all_movies= all_movies.find_all do |movie|
      movie[:title].downcase.include?(@search.downcase) ||
      if movie[:synopsis]
        movie[:synopsis].downcase.include?(@search.downcase)
      end
    end
  end
  if !@search
    @all_movies = pagination(@all_movies, @page, offset)
  end
  erb :movies
end

get '/movies/:movie_id' do
  @movie_id = params[:movie_id]
  @movie = all_movies.select {|movie| movie[:id] == @movie_id}
  erb :movie
end
