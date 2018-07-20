class ReviewsController < ApplicationController
  def create
    
    prod = Product.find params['product_id']
    @newReview = prod.reviews.create({
      user_id: current_user.id,
      rating: params['rating'],
      description: params['description']
    })
    
    redirect_to :back
  end
end
