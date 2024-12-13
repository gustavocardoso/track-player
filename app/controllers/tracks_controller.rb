class TracksController < ApplicationController
  layout "admin"

  include ActiveStorage::SetCurrent

  def index
    @tracks = Track.includes(file_attachment: :blob).order(:title)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @tracks }
      format.json { render json: @tracks.as_json(include: { file_attachment: { include: :blob } }) }
    end
  end

  def all
    @tracks = Track.includes(file_attachment: :blob).order(:title)
    render json: @tracks.as_json(include: { file_attachment: { include: :blob } })
  end

  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      # Attach the file to the track
      @track.file.attach(params[:track][:file]) if params[:track][:file].present?

      redirect_to @track, notice: 'Track was successfully created.'
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to tracks_url, notice: "Track updated with success!" }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @track = Track.find(params[:id])
    if @track.destroy
      redirect_to tracks_url, notice: "Track deleted with success!"
    else
      redirect_to tracks_url, notice: "An error occurred and the track was not deleted!"
    end
  end

  private

  def track_params
    params.require(:track).permit(:title, :artist, :bpm, :duration, :observations, :file, :volume)
  end
end
