class ArticlesController < ApplicationController
  before_action :correct_user

  def index
     @user = User.find(params[:user_id])
      @articles = @user.articles.all
  end
	def show
        @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
  end
 def new
      @user = User.find(params[:user_id])
  @article = @user.articles.new
end

def edit
      @user = User.find(params[:user_id])
  @article = @user.articles.find(params[:id])
end
 
def create
  @user = User.find(params[:user_id])
  @article = @user.articles.new(article_params)
 
  if @article.save
    redirect_to user_articles_url
  else
    render 'new'
  end
end

def update
        @user = User.find(params[:user_id])

  @article = @user.articles.find(params[:id])
 
  if @article.update(article_params)
    redirect_to user_articles_url
  else
    render 'edit'
  end
end

def destroy
        @user = User.find(params[:user_id])
  @article = @user.articles.find(params[:id])
  @article.destroy
 
  redirect_to user_articles_path
end
private
  def article_params
    params.require(:article).permit(:title, :text)
  end


    # Confirms a logged_in user_
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
end