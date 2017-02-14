class ArticlesController < ApplicationController
#    callbacks
    before_action :authenticate_user!, except: [:show,:index]
    before_action :set_article, except: [:index,:new,:create]
    # GET /articles
    def index
        # Todos los registros
        # @article esto es una  variable clase, lo que hace es reflejar lo que hay en el controlador a la vista como si fuera un scope inician con una @
        @articles = Article.all
    end
    
    #GET /articles/:id
    def show
        @article.update_visits_count
        @comment = Comment.new
    end
    
    #GET /articles/new
    def new
        @article = Article.new
    end
    #POST /articles
    def create        
        @article = current_user.articles.new(article_params)
        if @article.save
            redirect_to @article
        else
            render :new
        end  
    end
    #PUT /article/:id
    def update
        if @article.update(article_params)
            redirect_to @article
        else
            render :edit
        end
    end
    #DELETE /articles/:id
    def destroy
        
        @article.destroy #Elimina elobjeto de la base de datos
        redirect_to articles_path
    end
    
    def edit
    end
    #metodos privados de la clase
   private
    
    
    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title,:body,:cover)
    end
    
end