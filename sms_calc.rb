require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require './rpn_calculator'
require 'httpclient'
require 'open-uri'

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
  proxy = ENV['HTTP_PROXY']
  clnt = HTTPClient.new(proxy)
  clnt.set_cookie_store("cookie.dat")
  target = ARGV.shift || "http://en.wikipedia.org/wiki/Main_Page"

  puts
  puts '= GET content directly'
  mystring = clnt.get_content(target)
  puts mystring
  
  @client = Twilio::REST::Client.new account_sid, auth_token
  @client.account.sms.messages.create(
  :from => '+14155992671',
  :to => '510-220-7769',
  :body => clnt.get_content(mystring)
  )
end

get '/hi' do
  file = open('http://en.wikipedia.org/wiki/Hedy_Lamarr')
  contents = file.read
  "<Response><Say>" + contents + "</Say></Response>"
end
