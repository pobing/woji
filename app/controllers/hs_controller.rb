class HsController < ApplicationController
  # GET /hs
  # GET /hs.json
  def index
    @hs = H.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hs }
    end
  end

  # GET /hs/1
  # GET /hs/1.json
  def show
    @h = H.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @h }
    end
  end

  # GET /hs/new
  # GET /hs/new.json
  def new
    @h = H.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @h }
    end
  end

  # GET /hs/1/edit
  def edit
    @h = H.find(params[:id])
  end

  # POST /hs
  # POST /hs.json
  def create
    @h = H.new(params[:h])

    respond_to do |format|
      if @h.save
        format.html { redirect_to @h, notice: 'H was successfully created.' }
        format.json { render json: @h, status: :created, location: @h }
      else
        format.html { render action: "new" }
        format.json { render json: @h.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hs/1
  # PUT /hs/1.json
  def update
    @h = H.find(params[:id])

    respond_to do |format|
      if @h.update_attributes(params[:h])
        format.html { redirect_to @h, notice: 'H was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @h.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hs/1
  # DELETE /hs/1.json
  def destroy
    @h = H.find(params[:id])
    @h.destroy

    respond_to do |format|
      format.html { redirect_to hs_url }
      format.json { head :no_content }
    end
  end
end
