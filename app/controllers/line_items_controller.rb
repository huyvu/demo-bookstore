class LineItemsController < ApplicationController
     skip_before_filter :authorize, :only => [:create, :show, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    begin
      @line_item = LineItem.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to home_url, notice: 'Invalid cart'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @line_item }
      end
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    book = Book.find(params[:book_id])
    # @line_item = @cart.line_items.build(:book => book)
    @line_item = @cart.add_book(book.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Line item was successfully created.' }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @cart = current_cart
    @line_item = @cart.line_items.find(params[:id])
    unless params[:quantity].nil?
      @line_item.update_attribute(:quantity, params[:quantity])
    end
    

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @cart, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @cart, alert: "The quantity you just entered is invalid.Please try again" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to @cart }
      format.json { head :no_content }
    end
  end


end
