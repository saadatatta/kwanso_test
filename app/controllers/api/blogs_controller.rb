module Api
    class BlogsController < ApiController
        before_action :authenticate_api_user!

        def index
            blogs = current_user.blogs
            render json: blogs, status: 200
        end

        def create
            @blogs = current_user.blogs.create(blog_params)
            if @blogs.persisted?
                if params[:images].present? && params[:images] != "null"
                    begin
                        @blogs.images.attach(params[:images])
                    rescue Exception=>e
                        render_error_message("something went wrong when uploading images")
                        return
                    end
                end
                render json: @blogs, status: :created
            else
                render_resource_error_message(@blogs)
            end
        end

        def update
            @blog = current_user.blogs.find(params[:id])
            if @blog.update(blog_params)
                if params[:images].present? && params[:images] != "null"
                    begin
                        @blog.images.attach(params[:images])
                    rescue Exception=>e
                        render_error_message("something went wrong when uploading images")
                        return
                    end
                end
                render json: @blog, status: :ok
            else
                render_resource_error_message(@blog)
            end
        end

        def show
            blog =  current_user.blogs.find(params[:id])
            if blog.present?
                render json: blog, status: 200
            end
        end

        def destroy
            blog =  current_user.blogs.find(params[:id])
            if blog.destroy
                render_message('Blog deleted successfully')
            else
                render_error_message('There was error deleting blog. Please try again')
            end
        end

        private

        def blog_params
            params.permit(:title, :description, images: [])
        end

    end
    
end