class UsersController < ApplicationController
    def new
        @user = User.new #inorder to validate the inputs
    end
    def show
        @user = User.all
    end

end
