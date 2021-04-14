class SongsController < ApplicationController
  def index
    # byebug
    if params[:artist_id]
      artist = Artist.find_by(id: params[:artist_id])
      if artist.nil?
        flash[:alert] = "Artist not found"
        redirect_to artists_path
      else 
        @songs = artist.songs
        if @songs.nil?
          flash[:alert] = "Song not found"
          redirect_to artists_path
        end
      end
    else
      @songs = Song.all
      if @songs.nil?
        flash[:alert] = "Song not found"
        redirect_to artists_path
      end
    end
  end

  def show
    @song = Song.find_by(id: params[:id])
    if params[:artist_id]
      if @song.nil?
        # byebug
        if Artist.find_by(id: params[:artist_id]).nil?
          flash[:alert] = "Artist not found"
          redirect_to artists_path
        else
          flash[:alert] = "Song not found"
          redirect_to artist_songs_path(Artist.find_by(id: params[:artist_id]))
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
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

