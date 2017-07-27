require 'securerandom'

get '/' do
	@urls = Url.all.order("created_at DESC")
  	erb :"static/index"
end

post '/shorten' do 
	@url = Url.new(long_url: params[:long_url], short_url: SecureRandom.hex(8))
	if @url.save
		
	else
		@errors = @url.errors.full_messages.join(",")
		#this is the error messahe given from Active Record because it does not pass the validation stated on model urb

	end

	@urls = Url.all.order("created_at DESC")
	erb :"static/index"
end

post '/:id/vote' do
	@url = Url.find(params[:id])
	@url.click_count += 1
	@url.save
	redirect '/'

end

get '/:short' do
	@url = Url.find_by(short_url: params[:short])
	@url.click_count += 1
	@url.save

	redirect to "#{@url.long_url}"

end