require 'rubygems'
require 'sinatra'
=begin
require 'twilio-ruby'


# put your own credentials here
account_sid = 'AC60c309b5c40342009c38e91c468ff41a'
auth_token = '45c473926f66f85d5ec3bf82f318c305'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

# send an sms
@client.account.sms.messages.create(
  :from => '+14155992671',
  :to => '510-220-7769',
  :body => 'Kaltxi ma Judy! Nga lu fpom srak?'
)
=end

get '/' do
  "Hello from Sinatra on Heroku lololol!"
end
