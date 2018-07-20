class ReviewsController < ApplicationController
  
  before_filter  do 
    redirect_to "/" unless current_user
    flash[:notice] = 'You dont have enough permissions to be here' unless current_user
  end

  before_action only: [:destroy] do
    redirect_to :back unless Review.where("id = ? and user_id = ?", params[:id], current_user.id).exists?
  end

  def create
    
    prod = Product.find params['product_id']
    @newReview = prod.reviews.create({
      user_id: current_user.id,
      rating: params['rating'],
      description: params['description']
    })
    
    redirect_to :back
  end

  def destroy

    Review.destroy(params[:id])

    redirect_to :back
  end
end
