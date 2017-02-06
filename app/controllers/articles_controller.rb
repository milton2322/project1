class ArticlesController < ApplicationController
    # GET /articles
    def index
        # Todos los registros
        @articles= Article.all
    end
    #GET /articles/:id
    def show
# @article esto es una  variable clase, lo que hace es reflejar lo que hay en el controlador a la vista como si fuera un scope inician con una @
        @article = Article.find(params[:id])
    end
    
    #GET /articles/new
    def new
        @article = Article.new
    end
    #POST /articles
    def create        
#        @article = Article.new(title: params[:article][:title],body: params[:article][:body])
        # si no hay nada en el cuerpo queda en el new
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article
        else
            render :new
        end  
    end
    #PUT /article/:id
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to @article
        else
            render :edit
        end
    end
    #DELETE /articles/:id
    def destroy
        @article = Article.find(params[:id])
        @article.destroy #Elimina elobjeto de la base de datos
        redirect_to articles_path
    end
    
    def edit
        @article = Article.find(params[:id])
    end
    #metodos privados de la clase
   private
    
    def article_params
        params.require(:article).permit(:title,:body)
    end
    
end