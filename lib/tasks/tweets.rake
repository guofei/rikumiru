namespace :tweets do
  task reset_keyword: :environment do
    Tweet.where(useful: true, keyword: nil).each do |tweet|
      if tweet.keywords.count > 0
        tweet.keyword = tweet.keywords.first
      else
        Keyword.find_each do |keyword|
          if tweet.text.include? keyword.name
            tweet.keyword = keyword
            break
          end
        end
      end
      if tweet.keyword
        tweet.save
      else
        tweet.keyword_id = 0
        tweet.save
      end
    end
  end
end
