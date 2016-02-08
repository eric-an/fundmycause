class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/causes' 
    else
      erb :"users/new"
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      erb :"users/show", locals: {message: "Account successfully created."}
    else
      erb :"users/new", locals: {message: "Please fill in all fields."}
    end
  end
  
  get '/login' do
    if logged_in?
      redirect to '/causes'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/causes'
    else
      erb :"users/login", locals: {message: "Please provide the correct login."}
    end
  end

  get '/user/:id' do
    if logged_in? && current_user.id == params[:id].to_i
      @user = current_user
      erb :"users/show"
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end