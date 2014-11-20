class Tweet < ActiveRecord::Base
  belongs_to :company
  belongs_to :keyword
  default_scope { order("created_at desc") }

  before_destroy do
    change_tweet_count_before_destroy
  end
  before_create :change_tweet_count_before_create
  before_update :change_tweet_count_before_update

  paginates_per 100

  def self.period_count_array(from = 31.days.ago.beginning_of_day, to = Date.yesterday.end_of_day)
    unscoped.where(useful: true).where(created_at: from..to).group('date(created_at)').count
  end

  def change_tweet_count_before_create
    if keyword
      if useful == true
        keyword.increment!(:tweet_count)
        keyword.company_tweet_count.increment [company.id] if keyword.company_tweet_count.member? company.id
      end
    end
    if useful == true
      company.increment!(:tweet_count)
    end
  end

  def change_tweet_count_before_update
    if keyword
      if useful_changed?
        if useful == true
          keyword.increment!(:tweet_count)
          keyword.company_tweet_count.increment [company.id] if keyword.company_tweet_count.member? company.id
        elsif useful != true && useful_was == true
          keyword.decrement!(:tweet_count)
          keyword.company_tweet_count.decrement [company.id] if keyword.company_tweet_count.member? company.id
        end
      end
    end
    if useful_changed?
      if useful == true
        company.increment!(:tweet_count)
      elsif useful != true && useful_was == true
        company.decrement!(:tweet_count)
      end
    end
  end

  def change_tweet_count_before_destroy
    if keyword
      if useful == true
        keyword.decrement!(:tweet_count)
        keyword.company_tweet_count.decrement [company.id] if keyword.company_tweet_count.member? company.id
      end
    end
    if useful == true
      company.decrement!(:tweet_count)
    end
  end
end
