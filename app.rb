require 'bundler'
Bundler.require :default
Dotenv.load '.env'
require_relative './app/constants.rb'

module Banana
  class App < Sinatra::Base
    use Rack::Session::Cookie, secret: COOKIE_SECRET
    set :public_folder, File.dirname(__FILE__) + '/bower_components'

    get '/' do
      if logged_in?
        haml :welcome_in, layout: :layout
      else
        haml :log_in, layout: :layout
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
      begin
        session['access_token'] = session['oauth'].get_access_token(params[:code])
      rescue
        redirect '/?error=user_denied'
      end
      redirect '/'
    end

    def logged_in?
      !session['access_token'].nil?
    end

    def toggle_access
      logged_in? ? '/log_out' : '/log_in'
    end

    def graph
      @graph ||= Koala::Facebook::API.new(session['access_token'])
    end

    def errored?
      !params["error"].nil?
    end

    def user
      if @user.nil?
      user_data = graph.get_object('me', { fields: 'id,first_name,last_name,gender,birthday,photos,picture'})
      end

      @user ||= OpenStruct.new(
        name: user_data["first_name"],
        photo: user_data["picture"]["data"]["url"]
      )
    end
  end
end
