require_relative "recipe"
require "csv"

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    save_to_csv
  end

  def mark_as_done(recipe_index)
    @recipes[recipe_index].done!
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  private

  def load_csv
    CSV.foreach(@csv) do |row|
      # Here, row is an array of columns
      saved_recipe = Recipe.new(row[0], row[1], row[2], row[3])
      saved_recipe.done! if row[4] == "true"
      @recipes << saved_recipe
      # puts row
    end
  end

  def save_to_csv
    CSV.open(@csv, "wb") do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done] }
    end
  end
end
