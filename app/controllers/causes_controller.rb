class CausesController < ApplicationController

  get '/causes' do
    @causes = Cause.all
    erb :"causes/index"
  end

  get '/causes/new' do
    if logged_in?
      erb :"causes/new"
    else
      redirect to '/login'
    end
  end

  post '/causes/new' do
    @user = current_user
    @cause = Cause.new(name: params[:cause][:name])
    @cause.description = params[:cause][:description]
    @cause.funding = params[:cause][:funding]
    if params[:cause][:category_id]
      @cause.category_id = params[:cause][:category_id]
    else
      @cause.category = Category.find_or_create_by(name: params[:new_category].capitalize)
    end

    if @cause.save
      @cause.users << @user if !@cause.users.include?(@user)
      redirect to "/causes"
    else
      erb :"causes/new", locals: {message: "The cause wasn't created."}
    end
  end

  get '/cause/:id' do
    @cause = Cause.find_by(id: params[:id])
    erb :"causes/show"
  end

  post '/cause/:id/join' do
    if logged_in?
      @user = current_user
      @cause = Cause.find_by(id: params[:id])
      @user.causes << @cause if !@user.causes.include?(@cause)
      redirect to "/user/#{@user.id}"
    else
      redirect to '/login'
    end
  end

  get '/cause/:id/edit' do
    if logged_in?
      @user = current_user
      @cause = Cause.find_by(id: params[:id])
      if @cause.users.first == @user
        erb :"causes/edit"
      else
        redirect to '/causes'
      end
    else
      redirect to '/causes'
    end
  end

  patch '/cause/:id/edit' do
    @cause = Cause.find_by(id: params[:id])
    @cause.name = params[:cause][:name]
    @cause.description = params[:cause][:description]
    @cause.funding = params[:cause][:funding]
    if params[:cause][:category_id]
      @cause.category_id = params[:cause][:category_id]
    else
      @cause.category = Category.find_or_create_by(name: params[:new_category].capitalize)
    end

    if @cause.save
      redirect to "/cause/#{@cause.id}"
    else
      erb :"causes/show", locals: {message: "The cause wasn't updated."}
    end
  end

  post '/cause/:id/remove' do
    @cause = Cause.find_by(id: params[:id])
    @user = current_user
    if @cause.users.include?(@user)
      @cause.users.delete(@user)
      redirect to "/user/#{@user.id}"
    else
      redirect to '/causes'
    end
  end

  delete '/cause/:id/delete' do
    if logged_in?
      @user = current_user
      @cause = Cause.find_by(id: params[:id])
      if @cause.users.first == @user
        @cause.destroy
        erb :"users/show", locals: {message: "The cause was deleted."}
      else
        redirect to '/causes'
      end
    else
      redirect to '/causes'
    end
  end
end