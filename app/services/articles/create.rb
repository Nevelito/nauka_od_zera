module Articles
  class Create
    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call
      article = Article.new(params)

      if article.save
        { success: true, article: article }
      else
        { success: false, errors: article.errors.full_messages }
      end
    end
  end
end