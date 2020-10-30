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
        return final_rating
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

  def self.add_tmdb_movie(tmdb_id)
    detail_of_movies = Tmdb::Movie.detail(tmdb_id)
    print(detail_of_movies)
    movie_check = {:id => detail_of_movies["id"], :title => detail_of_movies["title"], :rating => rating_of_movie(detail_of_movies["id"]), :release_date => detail_of_movies["release_date"]}
    print(movie_check)
    # byebug
    Movie.create!(movie_check)
  end

end
