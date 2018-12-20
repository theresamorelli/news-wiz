class MashesController < ApplicationController
  # def index
  #   @mashes = Mash.all
  #   render json: @mashes
  # end

  def create
    @mash = Mash.new(mash_params)
    if @mash.save
      render json: @mash.to_json
    else 
      render json: @mash.errors
    end
  end

  def getTopMashWords
    # Get data using News API's library
    newsapi = News.new(ENV['NEWS_API_KEY']);
    stories = newsapi.get_top_headlines(sources: 'the-new-york-times,bbc-news,the-economist,the-washington-post,the-wall-street-journal,fox-news,breitbart-news,al-jazeera-english,politico,rt,reuters,associated-press,cnn,msnbc,google-news,the-huffington-post', language: 'en', sortBy: 'relevancy')

    @words = Mash.getWordStrings(stories)
    render json: @words
  end

  def queryMashWords
    # Get data using News API's library
    newsapi = News.new(ENV['NEWS_API_KEY']);
    stories = newsapi.everything(language: 'en', category: 'general')

  end


  private

  # def _params
  #   params.require(:cloud).permit(:id, :user_id, :label, :words)
  # end
end
