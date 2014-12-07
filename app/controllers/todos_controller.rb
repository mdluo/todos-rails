class TodosController < ApplicationController
  def index
  end

  def all
     @todos = Todo.all
     render json: @todos
  end

  def create
      @todo = Todo.new
	  @todo.task = params[:task]
	  @todo.completed = params[:completed]
      @todo.save
      render json: @todo
  end

  def update
	  @todo = Todo.find(params[:id])
	  @todo.completed = !@todo.completed
      @todo.save
      render json: @todo
  end
	
  def toggle
	  @todos = Todo.all
	  @todos.find_each() do |todo|
		  todo.completed = params[:completed]
		  todo.save
	  end
      render json: @todos
  end

  def delete
	  if params[:id] != "-1"
		  @todo = Todo.find(params[:id])
		  @todo.destroy
		  render json: @todo
	  else
		  @todos = Todo.all
		  @todos.find_each() do |todo|
			  if todo.completed
			  	todo.destroy
			  end
		  end
		  render json: @todos
	  end
  end

end
