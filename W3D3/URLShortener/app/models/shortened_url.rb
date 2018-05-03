# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :text             not null
#  user_id    :integer          not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true
  validates :short_url, presence: true , uniqueness: true

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.create_short_url(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.new(long_url: long_url, user_id: user.id, short_url: short_url).save
  end


  has_many :visits
  primary_key: :id
  foreign_key: :url_id
  class_name: :Visit

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :visitors,
  through: :visits,
  source: :user


  def num_clicks
    self.visits.count
  end



  # def num_clicks
  #   Visit.all.select { |vis| vis.url_id == self.id }.count
  # end

  def num_uniques
    unique = []
    Visit.all.each { |vis| unique << vis.user_id if vis.url_id == self.id }
    unique.uniq.count
  end



end
