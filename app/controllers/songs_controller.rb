require 'rack-flash'
class SongsController < ApplicationController
  use Rack::Flash

  get('/songs') {@songs=Song.all; erb :'/songs/index'}
  get('/songs/new') {erb :'/songs/new'}
  get('/songs/:slug') {@song=Song.find_by_slug(params[:slug]); erb :'songs/show'}
  get('/songs/:slug/edit') {@song=Song.find_by_slug(params[:slug]); erb :'songs/edit'}

  post '/songs' do
    @song = Song.create(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save
    flash[:message] = "Successfully updated song."
    redirect("/songs/#{@song.slug}")
  end

end
