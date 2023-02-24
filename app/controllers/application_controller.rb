class ApplicationController < Sinatra::Base

    set :default_content_type, 'application/json'

    get '/games' do
      games = Game.all.order(:title)

      games.to_json
    end

    get '/games/:id' do
        game_id = params[:id]
        game = Game.find(game_id) 
        game.to_json(include: {reviews: {include: :user}})
    end

    post '/games' do
       game = Game.create(
        title: params[:title],
        genre: params[:genre],
        platform: params[:platform],
        price: params[:price]) 
       game.to_json
    end

    patch '/games/:id' do
        game = Game.find(params[:id])
        game.update(
            title: params[:title],
            genre: params[:genre],
            platform: params[:platform],
            price: params[:price]) 
        game.to_json 
    end

    delete '/games/:id' do
        game = Game.find(params[:id])
        game.destroy
        "Deleted #{game.title}"
    end
  
end