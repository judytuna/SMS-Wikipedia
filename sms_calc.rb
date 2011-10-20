require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require './rpn_calculator'

account_sid = 'AC60c309b5c40342009c38e91c468ff41a'
auth_token = '45c473926f66f85d5ec3bf82f318c305'

get '/' do
  "Hi! Send a text to (415) 599-2671 with Judy's PIN and two numbers, and you'll get back their sum!!!"
  # set up a client to talk to the Twilio REST API
#  @client = Twilio::REST::Client.new account_sid, auth_token

  # send an sms
#  @client.account.sms.messages.create(
#  :from => '+14155992671',
#  :to => '510-220-7769',
#  :body => 4 + 4
  )
end

post '/calc' do
  mycalc = RPNCalculator.new
  myanswer = mycalc.evalutate(params[:Body])

  "<Response><Sms>Your answer: <%= myanswer %>.</Sms></Response>"
end


