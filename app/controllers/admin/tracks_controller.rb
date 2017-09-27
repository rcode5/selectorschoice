class Admin::TracksController < AdminController
  def index
    @published, @unpublished = Track.by_recency.partition(&:published)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tracks }
    end
  end

  def show
    @track = Track.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @track }
    end
  end

  def new
    @track = Track.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @track }
    end
  end

  def clone
    @track = Track.find(params[:id]).dup
    @track.published = false
    @track.url = ''
    render 'new'
  end

  def edit
    @track = Track.find(params[:id])
  end

  def create
    set_recorded_on_from_params
    @track = Track.new(track_params)
    respond_to do |format|
      if @track.save
        format.html { redirect_to admin_track_path(@track), notice: 'Track was successfully created.' }
        format.json { render json: @track, status: :created, location: @track }
      else
        format.html { render action: "new" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @track = Track.find(params[:id])
    set_recorded_on_from_params
    respond_to do |format|
      if @track.update_attributes(track_params)
        format.html { redirect_to admin_track_path(@track), notice: 'Track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    respond_to do |format|
      format.html { redirect_to admin_tracks_url }
      format.json { head :no_content }
    end
  end

  private
  def track_params
    params.require(:track).permit(:description, :display_title, :playlist, :recorded_on, :title, :url, :tag_list, :style_list, :author, :published)
  end

  def set_recorded_on_from_params
    params[:track][:recorded_on] = params[:recorded_on_day] || ''
    if params[:recorded_on_time].present?
      params[:track][:recorded_on] = Time.zone.parse([params[:track][:recorded_on],params[:recorded_on_time]].join ' ' )
    end
    params[:track].delete(:recorded_on) unless params[:track][:recorded_on].present?
  end
end
