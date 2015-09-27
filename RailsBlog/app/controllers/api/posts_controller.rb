class Api::PostsController < ApplicationController

 #    api_posts GET    /api/posts(.:format)     api/posts#index
    def index
        user = User.find_by({token: env['HTTP_TOKEN']})
        render json: user.posts
    end



 #          POST   /api/posts(.:format)     api/posts#create

    def create
        user = User.find_by({token: env['HTTP_TOKEN']})
        post = user.posts.create(post_params)
        render json: post
    end


 # api_post GET    /api/posts/:id(.:format) api/posts#show

    def show
        user = User.find_by({token: env['HTTP_TOKEN']})
        render json: user.posts.find(params[:id])
    end

 #          PATCH  /api/posts/:id(.:format) api/posts#update
 #          PUT    /api/posts/:id(.:format) api/posts#update
     def update
         user = User.find_by({token: env['HTTP_TOKEN']})
         post = user.posts.find(params[:id])
         post.update(post_params)
         render json: post

     end

 #          DELETE /api/posts/:id(.:format) api/posts#destroy
     def destroy
          user = User.find_by({token: env['HTTP_TOKEN']})
          user.posts.destroy(params[:id])
          render json: {status: 202, message: 'post destroyed'}
     end


 private

     def post_params
         params.require(:post).permit(:name)
     end

end
