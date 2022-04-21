class TasksController < ApplicationController
  before_action :categories_all, except: [:destroy]
  protect_from_forgery except: :edit

  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result.not_done.page(params[:page])
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスクを作成しました'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'タスクを更新しました'
      redirect_to task_path
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.js
      end
    end
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    flash[:success] = 'タスクを削除しました'
    redirect_to root_path
  end

  private
    def task_params
      params.require(:task).permit(:name, :body, { category_ids: [] }, :priority, :ended_at, :status)
    end

    def categories_all
      @categories = Category.all
    end
end
