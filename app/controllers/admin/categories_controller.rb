class Admin::CategoriesController < ApplicationController
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]

  # GET /admin/categories
  # GET /admin/categories.json
  def index
    @categories = Category.all
  end

  # GET /admin/categories/1
  # GET /admin/categories/1.json
  def show
  end

  # GET /admin/categories/new
  def new
    @category = Category.new
  end

  # GET /admin/categories/1/edit
  def edit
  end

  # POST /admin/categories
  # POST /admin/categories.json
  def create
    @category = Category.new(category_params)

      if @category.save
        redirect_to [:admin, :categories], notice: 'Category was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /admin/categories/1
  
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to [:admin, :categories], notice: 'Category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/categories/1
  
  def destroy

  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(
        :name
      )
    end
end
