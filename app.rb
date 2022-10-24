require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"

cookbook = Cookbook.new("recipes.csv")

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get "/" do
  @recipes = cookbook.all
  erb :index
end

get "/about" do
  erb :about
end

get "/new" do
  erb :new
end

post '/recipes' do
  recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:prep_time])
  cookbook.add_recipe(recipe)
  redirect "/"
end

post '/delete' do
  cookbook.remove_recipe(params[:idx].to_i)
  redirect '/'
end

post '/done' do
  cookbook.mark_as_done(params[:idx].to_i)
  # p params[:name]
  redirect '/'
end


get "/recipe/:index" do
  @recipe = cookbook.all[params[:index].to_i]
  erb :"recipe"
end
