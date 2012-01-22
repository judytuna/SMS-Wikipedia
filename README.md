SMS-Wikipedia
=============

Experimental voice interface for Wikipedia, mediated by the Twilio API. SMS a query to a shortcode,
get a call on your phone that reads the Wikipedia article to you.


Getting started
---------------

This is Sinatra app. You need to use or build some service that uses Sinatra. The authors used 
Heroku.

Certain settings must be available in the environment variables. You can add them directly in 
your shell configuration (e.g. .bash_profile), like so:

```bash
    # app settings for heroku/sinatra SMS-Wikipedia app
    export SMSWIKI_ACCOUNTSID='your Twilio account SID here'
    export SMSWIKI_AUTHTOKEN='your Twilio account auth token here'
    # what phone number the call with the speaking voice appears to be from
    export SMSWIKI_FROMPHONE='+14155551234'
```

Heroku has a [great system](http://devcenter.heroku.com/articles/config-vars) for getting config vars into apps this way. 

Once sourced into your shell, you can push these config vars to Heroku. Install the heroku gem, and use this incantation:

```bash
    $ cd SMS-Wikipedia
    $ for c in `env | grep SMSWIKI`; do heroku config:add $c; done;
```





