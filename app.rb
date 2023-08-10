require "sinatra"
require "sinatra/reloader"
require 'net/http'
require 'json'





def getRecipe(search_term)
  url = URI("https://api.edamam.com/api/recipes/v2?type=public&q=#{search_term}&app_id=26b3ada9&app_key=%2036259b904524c4e987b5a093707654fa")
  response = Net::HTTP.get(url)
  response_obj = JSON.parse(response)
  results = response_obj.fetch("hits")
end


get("/") do

  erb(:home)
end

post("/recipe_search") do

  search_term = params.fetch("search_term")
  @results = getRecipe(search_term)

  erb(:recipe)
end
