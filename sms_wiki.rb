require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require 'httpclient'
require 'open-uri'
require 'json'

get '/' do
  <<END
  Hi! Send an SMS to #{ENV['SMSWIKI_FROMPHONE']} with your query. I don't know about disambiguation yet.  Some to try:
  <ul>
    <li>Unicorn</li>
    <li>San Francisco 49ers</li>
    <li>Hedy Lamarr</li>
    <li>The Beatles</li>
    <li>Hackers (film)</li>
  </ul>
  I do know about parentheses, so that last one will work =) have fun! <br />
  <br />
  Code at: <a href="https://github.com/judytuna/SMS-Wikipedia">https://github.com/judytuna/SMS-Wikipedia</a><br/>
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

  languages = ['de', 'es', 'en', 'fr']

  if ( body =~ /(..)::(.*)/ )
    lang = $1
    pagetitle = $2
  else
    lang = 'en'
    pagetitle = body
  end

  callurl = URI::HTTP.build({
    :host => hostport,
    :path => pathPrefix + '/call',
    :query => 'lang=' + lang + '&page=' + URI.escape(pagetitle)
  })

  call = @client.account.calls.create(
    :from => ENV['SMSWIKI_FROMPHONE'],
    :to => userphone,
    :url => callurl.to_s
  )
end


post '/call' do
  puts 'we are in /call now'
  query = 'action=parse&format=json&redirects&page=' + URI.escape(params['page'])
  params['lang'] = params['lang'] || 'en'
  url = URI::HTTP.build({
    :host => params['lang'] + '.wikipedia.org', 
    :path => '/w/api.php', 
    :query => query
  }).to_s
 
  puts 'W'*52
  puts url

  file = open(url, 'User-Agent' => 'ruby')
  contents = file.read
  parsed = JSON.parse contents
  text = parsed['parse']['text']['*']
  lang = params['lang']
  stripped = text.gsub(/<table.*?<\/table>/m,"").gsub(/<\/?[^>]*>/,"")
  '<Response><Say voice="woman" language="' + lang +'">' + stripped + '</Say></Response>'
end
