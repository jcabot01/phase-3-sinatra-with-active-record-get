class ApplicationController < Sinatra::Base
#by default Sinatra sets a response header with Content-Type = text/html, so we want to reset that to JSON
set :default_content_type, 'application/json'

#routes
  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    # games = Game.all    #get all games from database
    # games = Game.all.order(:title)   #or order by title
    games = Game.all.order(:title).limit(10)
    games.to_json   #take returned data, convert to an array of json
  end

  get '/games/:id' do   #use the :id syntax to create a dynamic route
    game = Game.find(params[:id])   #look up game in the database using its :id
    # game.to_json  #send a JSON-formatted response of the game data
    # game.to_json(include: :reviews)   #not only do serialize to data into JSON, but want to include associated review data
    # game.to_json(include: { reviews: { include: :user }  })   #this respone includes each review for the game(id).  Also each user associated with that review
    game.to_json(only: [:id, :title, :genre, :price], include: {  #specify EXACTLY what data we want to see from each model
      reviews: { only: [:comment, :score], include: {
        user: {only: [:name] }
      } }
    })
  end

end
