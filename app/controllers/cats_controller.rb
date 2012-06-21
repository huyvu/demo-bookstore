class CatsController < ApplicationController
  skip_before_filter :authorize, :only => :show
  # GET /cats
  # GET /cats.json
  def index
    @cats = Cat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cats }
    end
  end

  # GET /cats/1
  # GET /cats/1.json
  def show
    begin
      @cat = Cat.find(params[:id])
      @books = Book.find_by_cat_id(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid category #{params[:id]}"
      redirect_to home_url, notice: 'Invalid category'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @cat }
      end
    end
  end

  # GET /cats/new
  # GET /cats/new.json
  def new
    @cat = Cat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cat }
    end
  end

  # GET /cats/1/edit
  def edit
    @cat = Cat.find(params[:id])
  end

  # POST /cats
  # POST /cats.json
  def create
    @cat = Cat.new(params[:cat])

    respond_to do |format|
      if @cat.save
        format.html { redirect_to @cat, notice: 'Cat was successfully created.' }
        format.json { render json: @cat, status: :created, location: @cat }
      else
        format.html { render action: "new" }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cats/1
  # PUT /cats/1.json
  def update
    @cat = Cat.find(params[:id])

    respond_to do |format|
      if @cat.update_attributes(params[:cat])
        format.html { redirect_to @cat, notice: 'Cat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cats/1
  # DELETE /cats/1.json
  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy

    respond_to do |format|
      format.html { redirect_to cats_url }
      format.json { head :no_content }
    end
  end
end
