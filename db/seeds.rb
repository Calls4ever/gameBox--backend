# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Game.destroy_all

require "uri"
require "net/http"

# url = URI("https://api.rawg.io/api/games")

# https = Net::HTTP.new(url.host, url.port);
# https.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request["Authorization"] = "token 427e5b91ccbed6e172681d8018b2fa2777c9739f"
# request["Content-Type"] = "text/plain"
# request["Cookie"] = "__cfduid=d3d33ed140d75bab15dca39b361c406ff1594060379"
# request.body = "{\"title\": \"My issue Title\", \"body\": \"what a large issue\"}\n"

# response = https.request(request)
# games = response.read_body

info = URI.parse("https://api.rawg.io/api/games")
response = Net::HTTP.get_response(info)
        game_info = JSON.parse(response.body)

            game_info["results"].each do |game|
            
            name = game["name"]
            rating = game["rating"]
            genre = (game["genres"].collect do |x|
                x['name']
            end).join(', ')
            
            platform = (game["parent_platforms"].collect do |x|
                x.collect do |p, v|
                    v["name"]
                end
            end).join(', ')
            img_url = game["background_image"]
            link = game["stores"][0]["url_en"]
            Game.create(name: name, rating: rating, img_ur: img_url, platform: platform, link: link, genre: genre)
            end
        