class ItemsController < ApplicationController
    
    def index
       @items = Item.all
       @categories = Category.all
    end
    
    def from_category
       @selected = Item.where(:category_id => params[:id])
       @parent_id = params[:id]
       
       respond_to do |format|
          format.js 
       end
    end
end
