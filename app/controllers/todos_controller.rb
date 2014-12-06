class TodosController < ApplicationController
  def index
  end

  def all
     @todos = Todo.all
     render json: @todos
  end

  def show
      @todo = Todo.find(params[:id])
      render json: @todo
  end

  def new
      @todo = Todo.new(params[:todo])
      @todo.save
      render json: @todo
  end

  def update
  end

  def delete
      render json: params[:id]
  end

end
