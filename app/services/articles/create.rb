module Articles
  class Create
    attr_reader :params
    def initialize(params)
      @params = params
    end

    def call
      article = Article.new(params)

      if article.save
        result = { success: true, article: article }
      else
        result = { success: false, errors: article.errors.full_messages }
      end
      result
    end
  end
end