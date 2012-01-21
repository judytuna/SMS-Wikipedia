require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require './rpn_calculator'
require 'httpclient'

account_sid = 'AC60c309b5c40342009c38e91c468ff41a'
auth_token = '45c473926f66f85d5ec3bf82f318c305'

get '/' do
  "Hi! Call or text (415) 599-2671 with Judy's PIN. Text app not done yet =)"
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

post '/calc' do
  proxy = ENV['HTTP_PROXY']
  clnt = HTTPClient.new(proxy)
  clnt.set_cookie_store("cookie.dat")
  target = ARGV.shift || "http://sharp-autumn-7065.heroku.com/"

  puts
  puts '= GET content directly'
  puts clnt.get_content(target)
  
  @client = Twilio::REST::Client.new account_sid, auth_token
  @client.account.sms.messages.create(
  :from => '+14155992671',
  :to => '510-220-7769',
  :body => clnt.get_content(target)
  )
end

post '/hi' do
  mytext = "hello there"
  "<Response><Say>" + mytext + "</Say></Response>"
end
