class TodoItemsController < ApplicationController
  before_action :set_page
  before_action :set_todo_list
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]

  # GET /todo_items/1
  # GET /todo_items/1.json
  def show
  end

  # GET /todo_items/new
  def new
    @todo_item = @todo_list.todo_items.new
  end

  # GET /todo_items/1/edit
  def edit
  end

  # POST /todo_items
  # POST /todo_items.json
  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    respond_to do |format|
      if @todo_item.save
        if (@page == '')
           format.html { redirect_to @todo_list, notice: 'Todo item was successfully created.' }
        else
           format.html { redirect_to [@todo_list, page: @page], notice: 'Todo item was successfully created.' }
        end
        format.json { render :show, status: :created, location: @todo_list }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_items/1
  # PATCH/PUT /todo_items/1.json
  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        if (@page == '')
           format.html { redirect_to @todo_list, notice: 'Todo item was successfully updated.' }
        else
           format.html { redirect_to [@todo_list, page: @page], notice: 'Todo item was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @todo_list }
      else
        format.html { render :edit }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_items/1
  # DELETE /todo_items/1.json
  def destroy
    @todo_item.destroy
    respond_to do |format|
      if (@page == '')
         format.html { redirect_to @todo_list, notice: 'Todo item was successfully destroyed.' }
      else
         format.html { redirect_to [@todo_list, page: @page], notice: 'Todo item was successfully destroyed.' }
      end
      format.json { head :no_content }
    end
  end

  private
    def set_page
      @page = params[:page]
    end

    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = @todo_list.todo_items.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_item_params
      params.require(:todo_item).permit(:title, :due_date, :description, :completed)
    end
end
