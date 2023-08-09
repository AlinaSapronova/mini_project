require "sinatra"
require "sinatra/reloader"
require 'net/http'
require 'json'





def getRecipe
  url = URI("https://api.edamam.com/api/recipes/v2?type=public&q=avocado&app_id=26b3ada9&app_key=%2036259b904524c4e987b5a093707654fa")
  uri = URI(url)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(url) 
  response = Net::HTTP.get(uri)
  response_obj = JSON.parse(response)
  results = response_obj.fetch("hits")
  return results
end


get("/") do

  erb(:home)
end

post("/recipe_search"){

  search_term = params.fetch("search_term")

  url = URI("https://api.edamam.com/api/recipes/v2?type=public&q=#{search_term}&app_id=26b3ada9&app_key=%2036259b904524c4e987b5a093707654fa")
  uri = URI(url)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(url) 
  response = Net::HTTP.get(uri)
  response_obj = JSON.parse(response)
  @results = response_obj.fetch("hits")

  erb(:recipe)
}
