require 'sinatra'

WAYS = { file:'ways.txt', all:[] }
Thread.new do
  loop do
    if WAYS[:updated] != (mtime= File.mtime(WAYS[:file]))
      WAYS[:all].replace File.readlines(WAYS[:file]).map(&:chomp)
      WAYS[:updated] = mtime
    end
    sleep 86400 # 1 day
  end
end

get "/" do
  @way = WAYS[:all].sample
  @way_num = WAYS[:all].index(@way)
  
  erb :index
end

get '/:reason' do
  @way = WAYS[:all][params[:reason].to_i]
  @way_num = WAYS[:all].index(@way)
  if @way.nil?
    # TODO Error message?
    redirect '/'
  end
  
  erb :index
end