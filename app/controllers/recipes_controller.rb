class RecipesController < ApplicationController
	before_action :set_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@recipes = Recipe.all.order("created_at DESC")
	end

	def show

	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Successfully created recipe."
		else
			render 'new'
		end
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def edit

	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe."
	end

	private

	def set_recipe
		@recipe = Recipe.find(params[:id])
	end

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end
end
