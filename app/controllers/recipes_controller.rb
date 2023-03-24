class RecipesController < ApplicationController

    before_action :authorize

  def index
    recipes = Recipe.all
    render json: recipes, status: :created
  end

  def create
    user = User.find_by(id: session[:user_id])
    recipe = user.recipes.create(recipe_params)
    if recipe.valid?
    render json: recipe, status: :created
    else
        render json: {errors: ["invalid recipe "]}, status: :unprocessable_entity
    end
  end

  private

  def authorize
    render json: { errors: ["login"]}, status: :unauthorized unless session.include? :user_id
  end

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end