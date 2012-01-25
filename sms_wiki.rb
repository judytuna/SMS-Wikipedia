require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require 'httpclient'
require 'open-uri'
require 'json'

get '/' do
  <<END
  Hi! Send an SMS to 415-799-4519 with your query. I don't know about capitals or disambiguation yet, so you'll have to make sure all the caps are correct. Some to try:
  <ul>
    <li>Unicorn</li>
    <li>San Francisco 49ers</li>
    <li>Hedy Lamarr</li>
    <li>The Beatles</li>
    <li>Hackers (film)</li>
  </ul>
  I do know about parentheses, so that last one will work =) have fun! <br />
  <br />
  Code at: <a href="https://github.com/judytuna/SMS-Wikipedia">https://github.com/judytuna/SMS-Wikipedia</a>
  #<form action="/call" method="POST">
  # <label for="page">Page:</label><input type="text" name="page" size="20">
  # <br/><input type="submit" value="submit"/>
  #</form>
END
end

get '/getsms' do
  hostport = request.host_with_port
  # analyze request.url for path? Irrelevant on heroku...
  pathPrefix = ''

  userphone = params['From']
  body = params['Body']
  
  @client = Twilio::REST::Client.new ENV['SMSWIKI_ACCOUNTSID'], ENV['SMSWIKI_AUTHTOKEN']

  callurl = URI::HTTP.build({
    :host => hostport,
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
  puts 'we are in /call now'
  query = 'action=parse&format=json&page=' + URI.escape(params['page'])
  url = URI::HTTP.build({
    :host => 'en.wikipedia.org', 
    :path => '/w/api.php', 
    :query => query
  }).to_s
 
  file = open(url, 'User-Agent' => 'ruby')
  contents = file.read
  parsed = JSON.parse contents
  text = parsed['parse']['text']['*']
  stripped = text.gsub(/<table.*?<\/table>/m,"").gsub(/<\/?[^>]*>/,"")
  "<Response><Say>" + stripped + "</Say></Response>"
end
