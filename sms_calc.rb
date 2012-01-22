require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require './rpn_calculator'
require 'httpclient'
require 'open-uri'
require 'json'

account_sid = 'AC60c309b5c40342009c38e91c468ff41a'
auth_token = '45c473926f66f85d5ec3bf82f318c305'

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
  userphone = params['From']
  body = params['Body']
  
  puts body
  puts userphone
  puts params.to_s

  @client = Twilio::REST::Client.new account_sid, auth_token

  call = @client.account.calls.create(
  :from => '+14155992671',
  :to => userphone,
  :url => 'http://sharp-autumn-7065.heroku.com/call?' + body
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

get '/call' do
  "<Say>hello</Say>"
  # pagename = params[
end
