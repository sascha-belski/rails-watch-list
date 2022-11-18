class ListsController < ApplicationController
    before_action :set_list, only: %i[ show edit update destroy ]

    def index
      @lists = List.all
    end
    
    def show
      @bookmarks = @list.bookmarks
      @bookmark = Bookmark.new
    end

    def new
      @list = List.new
    end

    def create
      @list = List.new(list_params)
      respond_to do |format|
        if @list.save
          format.html { redirect_to list_url(@list), notice: "List was successfully created." }
          format.json { render :show, status: :created, location: @list }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    end
    
    private

    def set_list
      @list = List.find(params[:id])
    end

    def list_params
        params.require(:list).permit(:name)
    end
end
