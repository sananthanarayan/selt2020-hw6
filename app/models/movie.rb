class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.rating_of_movie(id)
    rating = Tmdb::Movie.releases(id)
    rating1 = rating["countries"]

    rating1.each do |a|
      if a["iso_3166_1"] == "US"
        final_rating = a["certification"]
        final_rating
      end
    end
  end

class Movie::InvalidKeyError < StandardError ; end

 def self.find_in_tmdb(string)
   begin
     Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")

     tmdb_array = []

     movie_array = Tmdb::Movie.find(string)
     # print(movie_array)
     movie_array.each do |movie|
       # print movie
       tmdb_array << {:tmdb_id => movie.id, :rating => rating_of_movie(movie.id), :release_date => movie.release_date, :title => movie.title}
       # print(tmdb_array)

     end

   rescue Tmdb::InvalidApiKeyError
       raise Movie::InvalidKeyError, 'Invalid API key'
   end

   tmdb_array

 end

  def self.create_tmdb_movie(tmdb_id)
    detail_of_movies = Tmdb::Movie.detail(tmdb_id)
    hash_of_added_movies = {:tmdb_id => detail_of_movies["id"], :title => detail_of_movies["original_title"], :rating => rating_of_movie(movie.id), :release_date => detail_of_movies["release_date"]}
    Movie.create!(hash_of_added_movies)
  end

end
