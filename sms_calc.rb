require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require './rpn_calculator'
require 'httpclient'
require 'open-uri'
require 'json'

get '/' do
  <<END
  Hi! Call or text (415) 599-2671 with Judy's PIN. Text app not done yet =)
  <form>
   <label for="page">Page:</label><input type="text" name="page" size="20">
   <br/><input type="submit" value="submit"/>
  </form>
END

  # set up a client to talk to the Twilio REST API
#  @client = Twilio::REST::Client.new account_sid, auth_token

# the sandbox number is  (415) 599-2671
# my pin is 3940-6402

  # send an sms
#  @client.account.sms.messages.create(
#  :from => '+14155992671',
#  :to => '510-220-7769',
#  :body => 4 + 4
#  )
end

get '/calc' do
  hostport = request.host_with_port
  # analyze request.url for path? Irrelevant on heroku...
  pathPrefix = ''

  userphone = params['From']
  body = params['Body']
  
  @client = Twilio::REST::Client.new(
    ENV['SMSWIKI_ACCOUNTSID'], 
    ENV['SMSWIKI_AUTHTOKEN'], 
  )

  callurl = URI::HTTP.build({
    :host => hostport
    :path => pathPrefix + '/call',
    :query => 'page=' + URI.escape(body)
  })

  call = @client.account.calls.create(
    :from => ENV['SMSWIKI_FROMPHONE'],
    :to => userphone,
    :url => callurl.to_s
  )
end

get '/hi' do
  file = open('http://en.wikipedia.org/w/api.php?action=parse&format=json&page=Arnold%20Alas&prop=text')
  contents = file.read
  parsed = JSON.parse contents
  text = parsed['parse']['text']['*']
  stripped = text.gsub(/<\/?[^>]*>/,"")
  "<Response><Say>" + stripped + "</Say></Response>"
end

post '/call' do
  puts 'we are in call now'
  query = 'action=parse&format=json&page=' + URI.escape(params['page'])
  url = URI::HTTP.build({
    :host => 'en.wikipedia.org', 
    :path => '/w/api.php', 
    :query => query
  })
  
  file = open(url)
  contents = file.read
  parsed = JSON.parse contents
  text = parsed['parse']['text']['*']
  stripped = text.gsub(/<\/?[^>]*>/,"")
  "<Response><Say>" + stripped + "</Say></Response>"
end
