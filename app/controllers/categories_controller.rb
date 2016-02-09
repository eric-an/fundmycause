class CategoriesController < ApplicationController

  get '/categories' do
    @categories = Category.all
    erb :"categories/index"
  end
end