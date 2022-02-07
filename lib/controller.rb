require 'gossip'
class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    id = (Gossip.count_all)+1
    input = {author: params["gossip_author"] , content: params["gossip_content"]}
    Gossip.new(id,input[:author],input[:content]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    erb :show, locals: {output: Gossip.find_by_id(params[:id])}
  end
  
end