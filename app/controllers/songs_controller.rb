class SongsController < ApplicationController

  before_action :find_object, only: [:show, :edit, :update, :destroy]

  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @artist.nil? ? (redirect_to(artists_path, alert: "Artist not found")) : (@songs = @artist.songs)
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      if @artist = Artist.find_by(id: params[:artist_id])
        if @artist.songs.find_by(id: params[:id]).nil?
          redirect_to(artist_songs_path(@artist), alert: "Song not found")
        end
      end
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to(@song)
    else
      render(:new)
    end
  end

  def edit
  end

  def update
    @song.update(song_params)
    if @song.save
      redirect_to(@song)
    else
      render(:edit)
    end
  end

  def destroy
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to(songs_path)
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end

  def find_object
    @song = Song.find_by(id: params[:id])
  end
end

