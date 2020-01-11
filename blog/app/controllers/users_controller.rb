class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        redirect_to url_for(
            :controller => :articles,
            :action => :index,
            :user_id => params[:id]
        )
    end
end
