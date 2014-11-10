namespace :remove do
  desc "TODO"
  task url: :environment do
    loop do
      return unless Tweet.where("text like '%http%'").exists?
      Tweet.where("text like '%http%'").limit(10000).each do |tweet|
        tweet.destroy
      end
    end
  end
end
