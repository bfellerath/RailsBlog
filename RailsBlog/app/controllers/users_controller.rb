class UsersController < ApplicationController

    include SessionsHelper

    # def demo
    #     binding.pry
    # end


    # POST /users(.:format)     users#create
    def create
        User.create(user_params)
        redirect_to log_in_path
    end


    # new_user GET  /users/new(.:format) users#new
    def new
        @user = User.new
    end

#   profile GET  /users/profile(.:format) users#profile
    def profile
        authenticate!
        @user = current_user
    end





  #   log_in GET  /users/log_in(.:format)  users#log_in

    def log_in
    end



    private

    def user_params
        params.require(:user).permit(:username, :password)
    end



end
