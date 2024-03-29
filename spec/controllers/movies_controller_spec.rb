require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
   it 'should call the model method that performs TMDb search' do
     fake_results = [double('movie1'), double('movie2')]
     expect(Movie).to receive(:find_in_tmdb).with('Ted').and_return(fake_results)
     post :search_tmdb, {:search_terms => 'Ted'}
    end
    it 'should select the Search Results template for rendering' do
      allow(Movie).to receive(:find_in_tmdb)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(response).to render_template('search_tmdb')
    end
    it 'should make the TMDb search results available to that template' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(assigns(:movies)).to eq(fake_results)
    end
   it 'should redirect to the movies path for an empty array' do
     blank_results = []
     allow(Movie).to receive(:find_in_tmdb).and_return(blank_results)
     post :search_tmdb, {:search_terms => 'adfjka adjksfajkhsdf'}
     expect(response).to redirect_to('/movies')
   end
   it 'should redirect to movies path if search is empty' do
     post :search_tmdb, {:search_terms => ''}
     expect(response).to redirect_to('/movies')
   end
  end
end
