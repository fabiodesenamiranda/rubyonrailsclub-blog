# frozen_string_literal: true

module Administrate
  class ArticlesController < AdministrateController
    before_action :set_article, only: [ :show, :edit, :update, :destroy, :destroy_cover_image ]

    def index
      @articles = Article.all
    end

    # GET /articles/1 or /articles/1.json
    def show
    end

    # GET /articles/new
    def new
      @article = Article.new
    end

    # GET /articles/1/edit
    def edit
    end

    # POST /articles or /articles.json
    def create
      @article = Article.new(article_params)
      @article.cover_image.attached(article_params[:cover_image])

      respond_to do |format|
        if @article.save
          format.html { redirect_to(administrate_article_url(@article), notice: "Artigo criado com sucesso!") }
          format.json { render(:show, status: :created, location: @article) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @article.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /articles/1 or /articles/1.json
    def update
      respond_to do |format|
        if @article.update(article_params)
          if params[:article][:cover_image].present?
            @article.cover_image.attach(params[:article][:cover_image])
          end
          format.html { redirect_to(administrate_article_url(@article), notice: "Artigo atualizado com sucesso!") }
          format.json { render(:show, status: :ok, location: @article) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @article.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /articles/1 or /articles/1.json
    def destroy
      @article.destroy!

      respond_to do |format|
        format.html { redirect_to(administrate_article_url, notice: "Artigo apagado com sucesso!") }
        format.json { head(:no_content) }
      end
    end

    def destroy_cover_image
      @article.cover_image.purge

      respond_to do |format|
        format.turbo_stream { render(turbo_stream: turbo_stream.remove(@article)) }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :cover_image)
    end
  end
end
