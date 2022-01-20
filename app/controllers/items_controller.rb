class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :add_tag, :remove_tag]

  # GET /items
  def index

    @filterrific = initialize_filterrific(
      Item,
      params[:filterrific],
      persistence_id: "shared_key",
      available_filters: [:search_query, :with_tags]
    ) || return

    @items = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create
    split_variations
    @item = Item.new(item_params)

    if @item.save
      flash[:notice] = "Successfully added #{@item.name} to the inventory"
      redirect_to items_path
    else
      flash[:notice] = "Error creating item. Please try again!"
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    split_variations
    if @item.update(item_params)
      redirect_to items_path, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  def remove_tag
    tag = Tag.where(name: params[:tag]).first
    if tag and @item.tags.exists?(tag.id) and @item.tags.delete(tag)
      flash[:notice] = "Successfully remove #{tag.name} to #{@item.name}."
    else
        flash[:notice] = "Unable to find #{params[:tag]}."
    end

    redirect_to items_url
  end

  def add_tag
    tag = Tag.where(name: params[:tag]).first_or_create
    if not @item.tags.exists?(tag.id) and @item.tags << tag
        flash[:notice] = "Successfully add #{tag.name} to #{@item.name}."
    else
        flash[:notice] = "Unable to add #{tag.name} to #{@item.name}."
    end

    redirect_to items_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :desc, :qty, :tags, :retail_price, :wholesale_price,
                                   :last_updated, :supplier, variations: [])
    end

    def split_variations
      params[:item][:variations] = params[:item][:variations].first.split(",").map(&:strip)
    end

end
