class PostsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index 
        posts = Post.all
        render json: posts
    end

    def show 
        render json: find_post
    end

    def create 
        post = Post.create!(post_params)
        render json: post
    end

    def update 
        find_post.update!(likes: post_params[:likes])
        render json: find_post
    end

    def destroy
        find_post.destroy
        head :no_content
    end

    private 
 
    def record_not_found 
        render json: {error: "Record not found"}, status: :not_found
    end

    def find_post
        Post.find_by!(id: params[:id])
    end

    def post_params 
        params.permit(:title, :author, :text, :likes)
    end

    def record_invalid(error)
        render json: {error: error.record.errors.full_messages}, status: :unprocessable_entity
    end
end
