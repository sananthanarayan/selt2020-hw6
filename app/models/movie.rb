class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

class Movie::InvalidKeyError < StandardError ; end

 def self.find_in_tmdb(string)
   begin
     Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")

     tmdb_array = Tmdb::Movie.find(string)
     tmdb_array.each do |movie|
       matching_movies = Tmdb::Movie.find(movie)

     end

   rescue Tmdb::InvalidApiKeyError
       raise Movie::InvalidKeyError, 'Invalid API key'
   end

 end

end
