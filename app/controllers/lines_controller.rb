class LinesController < ApplicationController
  before_action :set_line, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /lines
  # GET /lines.json
  def index

    @transcript = Transcript.find(params[:transcript_id])
    # render plain: params.inspect
     @lines = @transcript.lines
     # render plain: @lines.inspect
  end

  # GET /lines/1
  # GET /lines/1.json
  def show
  end

  # GET /lines/new
  def new
    @line = Line.new
  end

  # GET /lines/1/edit
  def edit
    # render plain: params.inspect
    @transcript =  Transcript.find(params[:transcript_id])
    @line = Line.find(params[:id])
  end

  # POST /lines
  # POST /lines.json
  def create
    @line = Line.new(line_params)

    respond_to do |format|
      if @line.save
        format.html { redirect_to @line, notice: 'Line was successfully created.' }
        format.json { render :show, status: :created, location: @line }
      else
        format.html { render :new }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lines/1
  # PATCH/PUT /lines/1.json
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to @line, notice: 'Line was successfully updated.' }
        format.json { render :show, status: :ok, location: @line }
      else
        format.html { render :edit }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    @line.destroy
    respond_to do |format|
      format.html { redirect_to transcript_path(@line.transcript), notice: 'Line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_params
      params.require(:line).permit(:tc_in, :tc_out, :text, :n, :note, :tag, :transcript_id, :papercuts_attributes =>[:position])
    # not sure about :papercuts_attributes =>[:position]
    end
end
