require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    if logged_in?
      redirect to '/causes'
    else
      erb :"index"
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end
  end
end