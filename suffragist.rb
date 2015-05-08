require 'sinatra'
require 'yaml/store'

get '/' do
    @title = 'Welcome Shane!'
  erb :index
end

Choices = {
  'LIL' => "She'll never know how much",
  'NUF' => 'Not enough!',
  'SUM' => 'I love her loads!',
  'LOT' => 'More than dad loves spuds',
}

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end