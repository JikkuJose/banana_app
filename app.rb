require 'bundler'
Bundler.require :default
Dotenv.load '.env'
require_relative './app/constants.rb'

module Banana
  class App < Sinatra::Base
    use Rack::Session::Cookie, secret: COOKIE_SECRET

    get '/' do
      if logged_in?
        haml :welcome_in
      else
        haml :log_in
      end
    end

    get '/log_out' do
      session['oauth'] = nil
      session['access_token'] = nil

      redirect '/'
    end

    get '/log_in' do
      session['oauth'] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, "#{request.base_url}/call_back")
      redirect session['oauth'].url_for_oauth_code()
    end

    get '/call_back' do
      session['access_token'] = session['oauth'].get_access_token(params[:code])
      redirect '/'
    end

    def logged_in?
      !session['access_token'].nil?
    end
  end
end
