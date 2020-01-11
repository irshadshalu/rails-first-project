class CommentsController < ApplicationController
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end

    def destroy
        @article = Article.find(params[:article_id])
        if current_user.is_admin
            @comment = @article.comments.find(params[:id])
            @comment.destroy
        end
        redirect_to article_path(@article)
    end

    before_action :authenticate_user!
    private
    def comment_params
        params.require(:comment).permit(:commenter, :body)
    end
end
