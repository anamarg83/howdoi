require 'sinatra'

before do
  @ways ||= ['']
  if @ways[1].nil?
    @ways = File.readlines('ways.txt')
  end
end

get '/' do
  @way = @ways.sample

  erb :index
end

get '/:reason' do
  @way = @ways[params[:reason].to_i]
  if @way.nil?
    # TODO Error message?
    redirect '/'
  end
  
  erb :index
end