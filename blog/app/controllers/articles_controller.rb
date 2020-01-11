class ArticlesController < ApplicationController
    def index
        if(params[:user_id])
            @user = User.find(params[:user_id])
            @articles = @user.articles.paginate(page: params[:page], per_page: 10).order('created_at DESC')
        else
            @articles = Article.paginate(page: params[:page], per_page: 10).order('created_at DESC')
        end
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(article_params)
        print(@article)
        @article.user_id = current_user.id

        if @article.save
            redirect_to @article
        else
            render 'new'
        end
    end

    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
          redirect_to @article
        else
          render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    end

    before_action :authenticate_user!, :except => [:index, :show]
    before_action :authenticate_modify_access, :only => [:edit, :destroy]
end

private
    def article_params
        params.require(:article).permit(:title, :content, :post_date)
    end

    def authenticate_modify_access
        @article = Article.find(params[:id])
        if current_user.is_admin or @article.user != current_user
            redirect_to(root_path, :alert => "Permission Denied") and return
        end
    end