class LinksController < ApplicationController
  before_action :set_link, only: %i[root show edit update destroy]
  before_action :set_hlink, only: %i[root show create update]

  # Redirect to related url from root/:id
  def root
    redirect_to @link.url
  end

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show; end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit; end

  # POST /links
  # POST /links.json
  # Includes short url in response for API calls to create/update link.
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link, short_url: @hlink }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link, short_url: @hlink }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

  def set_link
    @link = Link.find(params[:id])
  end

  def set_hlink
    @hlink = "localhost:3000/#{@link.id.to_s(36)}"
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:url)
  end
end
