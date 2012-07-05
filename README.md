== Inviter

http://inviter.herokuapp.com

Sign-in using your Facebook or Foursquare account and set up an event in less than a minute.

**How It Works:**
1: Login using your Facebook or Foursquare account
2: Pick a time & a place for your event
3: Pick up to three nearby restaurants for your friends to vote on
4: Invite your friends to your event
5: See which restaurants your friends voted for & cater accordingly using LS Takeout & Delivery

== Additional setup instructions

 * install Postgres

 * create a Postgres user 'rails_user' with a password 'password' with CREATEDB rights

    CREATE USER rails_user WITH PASSWORD 'password' CREATEDB;

 * configure the following environment variables:
  * ENV['BING_MAPS_API_KEY']
  * ENV['FACEBOOK_KEY']
  * ENV['FACEBOOK_SECRET']
  * ENV['FOURSQUARE_KEY']
  * ENV['FOURSQUARE_SECRET']