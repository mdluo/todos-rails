class TodosController < ApplicationController
  def index
  end

  def all
    @todos = Array.new
    if cookies[:lat_lon] != nil
        cookies[:lat_lon].split(',').each { |value| @todos.push(Todo.where(:id => value.to_i).first) }
    end
       
      
    render json: @todos
  end

  def create
    @todo = Todo.new
      @todo.task = params[:task]
      @todo.completed = params[:completed]
      @todo.save

      if cookies[:lat_lon] != nil
          @idSet = cookies[:lat_lon].split(',')
      else
          @idSet = Array.new
      end

      @idSet.push @todo.id
      cookies.permanent[:lat_lon] = @idSet.join(',')

      
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
    @idSet = cookies[:lat_lon].split(',')
    if params[:id] != "-1"
      @todo = Todo.find(params[:id])
      @idSet = @idSet - [@todo.id.to_s]
      cookies.permanent[:lat_lon] = @idSet.join(',')
      @todo.destroy
      render json: @todo
    else
      @todos = Todo.all
      @todos.find_each() do |todo|
        if todo.completed
          todo.destroy
        end
      end
      render json: @todo
    end
  end

  def qrcode
    if cookies[:lat_lon] != nil

      content = Array.new
      cookies[:lat_lon].split(',').each do |id|
        task = Todo.where(:id => id.to_i).first
        content.push :id => id.to_i, :task => task[:task], :f => task[:completed]
      end

      data = { succeeded: true, code: view_context.generate_qrcode_base64(content.to_json, 384) }

    else
      data = { succeeded: false }
    end

    render json: data
  end

end
