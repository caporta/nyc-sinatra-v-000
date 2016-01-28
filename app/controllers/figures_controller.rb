class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    @figure.titles << Title.create(params[:title]) unless params[:title][:name].empty?
    @figure.landmarks << Landmark.create(params[:landmark]) unless params[:landmark][:name].empty?
    redirect '/figures'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    @figure.titles << Title.create(params[:title]) unless params[:title][:name].empty?
    @figure.landmarks << Landmark.create(params[:landmark]) unless params[:landmark][:name].empty?
    redirect "/figures/#{@figure.id}"
  end

end
