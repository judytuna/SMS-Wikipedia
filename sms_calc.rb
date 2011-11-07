require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require './rpn_calculator'

account_sid = 'AC60c309b5c40342009c38e91c468ff41a'
auth_token = '45c473926f66f85d5ec3bf82f318c305'

get '/' do
  "Hi! Call or text (415) 599-2671 with Judy's PIN. Text app not done yet =)"
  # set up a client to talk to the Twilio REST API
#  @client = Twilio::REST::Client.new account_sid, auth_token

  # send an sms
#  @client.account.sms.messages.create(
#  :from => '+14155992671',
#  :to => '510-220-7769',
#  :body => 4 + 4
#  )
end

post '/calc' do
  mycalc = RPNCalculator.new
  myanswer = mycalc.evaluate(params[:Body])

  "<Response><Sms> Hello." + "a" + "</Sms></Response>"
  # " + params[:Body] + " evaluates to " + myanswer + "
end

post '/hi' do
  "<Response><Say>Judy is super excited about Twilio! This is great!</Say></Response>"
end
