class BookmarksController < ApplicationController
    def new
        @list = List.find(params[:list_id])
        @bookmark = Bookmark.new
    end
    
    def create
        @comment = params[:bookmark][:comment]
        @list = List.find(params[:list_id])
        @movies = Movie.where(id: params.dig(:bookmark, :movie))
        return render_new if @movies.empty?
    
        ActiveRecord::Base.transaction do
          @movies.each do |movie|
            bookmark = Bookmark.new(comment: @comment, list: @list, movie: movie)
            bookmark.save!
          end
          redirect_to list_path(@list)
        end
      rescue ActiveRecord::RecordInvalid
        render_new
    end

    def destroy
        @bookmark = Bookmark.find(params[:id])
        @bookmark.destroy
        redirect_to list_path(@bookmark.list), status: :see_other
      end
    
    private
    
    def render_new
        @bookmark = Bookmark.new
        @bookmark.errors.add(:base, "A selected already exists")
        render :new, status: :unprocessable_entity
    end
end
